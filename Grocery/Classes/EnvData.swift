//
//  EnvData.swift
//  Grocery
//
//  Created by JM Velarde on 6/26/23.
//

import Foundation

enum CodingKeys: CodingKey {
    case recipeList, selectedRecipe
}

class EnvData: ObservableObject, Codable {
    
    static private var sampleData = Recipe(
        name: "Chicken Adobo",
        ingredients: [
            Ingredient(name: "chicken", quantity: 1, unit: "kg"),
            Ingredient(name: "garlic", quantity: 1, unit: "clove"),
            Ingredient(name: "onion", quantity: 1, unit: "pcs"),
            Ingredient(name: "soy sauce", quantity: 100, unit: "ml"),
            Ingredient(name: "vinegar", quantity: 50, unit: "ml"),
        ])
    
    @Published var recipeList: [Recipe] = []
    @Published var selectedRecipe = Recipe(name: "", ingredients: [])
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(recipeList, forKey: .recipeList)
        try container.encode(selectedRecipe, forKey: .selectedRecipe)
    }
    
    required init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        recipeList = try container.decode([Recipe].self, forKey: .recipeList)
        selectedRecipe = try container.decode(Recipe.self, forKey: .selectedRecipe)
    }
    
    init() {}
    
    func saveData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            UserDefaults.standard.set(encoded, forKey: "Data")
        }
    }
    
}
