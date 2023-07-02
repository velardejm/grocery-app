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
    
    
    
    @Published var recipeList: [Recipe] = []
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(recipeList, forKey: .recipeList)
        
    }
    
    required init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        recipeList = try container.decode([Recipe].self, forKey: .recipeList)
        
    }
    
    init() {}
    
    func saveData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            UserDefaults.standard.set(encoded, forKey: "Data")
        }
    }
    
}
