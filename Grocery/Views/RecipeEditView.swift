//
//  RecipeEditView.swift
//  Grocery
//
//  Created by JM Velarde on 6/30/23.
//

import SwiftUI

struct RecipeEditView: View {
    @Binding var recipe: Recipe
    
    @Binding var dataChanged: Bool
    @EnvironmentObject var envData: EnvData
    @State  var geom:GeometryProxy
    
    @State private var newName = ""
    @State private var newQuantity: Double? = nil
    @State private var newUnit = ""
    
    @State private var isShowingSaveConfirmation = false
    
    var addIngrButtonDisabled: Bool {
        if (newName.isEmpty || newQuantity == nil || newUnit == "") {
            return true
        }
        return false
    }
    
    var body: some View {
        Group {
            TextField("Name", text: $recipe.name)
            Section {
                HStack {
                    TextField("Name", text: $newName)
                    TextField("Quantity", value: $newQuantity, format: .number)
                    TextField("Unit", text: $newUnit)
                    Button {
                        addIngredient()
                    } label: {
                        Image(systemName: "plus.circle")
                    }.disabled(addIngrButtonDisabled)
                }.onSubmit {
                    addIngredient()
                }
            } header: {
                Text("Add Ingredient")
            }
            
            Section {
                ScrollView {
                    ForEach($recipe.ingredients) {$ingredient in
                        IngredientView(ingredient: $ingredient, availableWidth: geom.size.width * 0.85)
                    }
                }.frame(height: geom.size.height * 0.5)
            } header: {
                Text("Ingredients")
            }
        }.onChange(of: recipe, perform: {recipe in
            if !dataChanged {
                dataChanged = true
            }
        })
        
    }
    
    func addIngredient(){
        let newIngredient = Ingredient(id:1,
                                       name: newName, quantity: newQuantity ?? 0, unit: newUnit)
        recipe.ingredients.insert(newIngredient, at: 0)
        newName = ""
        newQuantity = nil
        newUnit = ""
    }
}

struct RecipeEditView_Previews: PreviewProvider {
    static var previews: some View {
        @State var recipe = Recipe(id:1 ,name: "", ingredients: [])
        @State var dataChanged = false
        GeometryReader {geom in
            RecipeEditView(recipe: $recipe, dataChanged: $dataChanged ,geom: geom)
        }
    }
}
