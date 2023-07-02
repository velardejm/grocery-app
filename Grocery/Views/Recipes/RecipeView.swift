//
//  RecipeView.swift
//  Grocery
//
//  Created by JM Velarde on 6/26/23.
//

import SwiftUI


struct RecipeView: View {
    @Binding var recipe: Recipe
    @State private var editingEnabled = false
    
    var body: some View {
        List {
            
            if !editingEnabled {
                Text("\(recipe.name)")
            } else {
                TextField("Recipe Name", text: $recipe.name).textFieldStyle(.roundedBorder)
            }
            
            Section {
                ForEach($recipe.ingredients) {$ingredient in
                    IngredientView(ingredient: $ingredient, editEnabled: $editingEnabled)
                }
            } header: {
                Text("Ingredients")
            }
            
            Button(editingEnabled ? "Save Changes" : "Edit Ingredients") {
                editingEnabled.toggle()
            }
        }
    }
    
    

}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        @State var recipe = Recipe(id: UUID(), name: "", ingredients: [])
        @State var editingEnabled = false
        RecipeView(recipe: $recipe)
    }
}
