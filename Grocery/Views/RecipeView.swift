//
//  RecipeView.swift
//  Grocery
//
//  Created by JM Velarde on 6/26/23.
//

import SwiftUI


struct RecipeView: View {
    @Binding var recipe: Recipe
    @EnvironmentObject var envData: EnvData
    @Environment(\.dismiss) var dismiss
    @State private var originalRecipe = Recipe(name: "", ingredients: [])
    @State private var isShowingSaveConfirmation = false
    @State private var isShowingDismissConfirmation = false
    
    @State private var newName = ""
    @State private var newQuantity: Double? = nil
    @State private var newUnit = ""
    
    @State private var addIngredientEnabled = false
    
    var addIngrButtonDisabled: Bool {
        if (newName.isEmpty || newQuantity == nil || newUnit == "") {
            return true
        }
        return false
    }
    
    var body: some View {
        GeometryReader {geom in
            List {
                if (!addIngredientEnabled) {
                    Text(recipe.name.capitalized)
                    Section {
                        ForEach(recipe.ingredients) {recipe in
                            HStack {
                                Text(recipe.name.capitalized)
                                Spacer()
                                Text("\(recipe.quantity, specifier: "%.2f")")
                                Text(recipe.unit.lowercased())
                            }
                        }
                    }
                }
                
                if (addIngredientEnabled) {
                    TextField("Name", text: $recipe.name)
                    Section {
                        ForEach($recipe.ingredients) {$ingredient in
                            IngredientView(ingredient: $ingredient, availableWidth: geom.size.width * 0.85)
                        }
                        
                    }
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
                    }
                    
                    Section {
                        Button("Save Changes") {
                            isShowingSaveConfirmation = true
                        }.alert("Save changes?", isPresented: $isShowingSaveConfirmation) {
                            Button("Yes") {
                                envData.saveData()
                            }
                            Button("Cancel") {print("Cancel")}
                        }
                    }
                }
            }.onAppear(perform: storeOriginalRecipe)
                .navigationBarBackButtonHidden(true)
                .navigationTitle("Recipe")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            if (originalRecipe == recipe) {
                                dismiss()
                            } else {
                                isShowingDismissConfirmation = true
                            }
                            
                        } label: {
                            Image(systemName: "chevron.backward")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            addIngredientEnabled = true
                        } label: {
                            Image(systemName: "square.and.pencil")
                        }
                    }
                }
                .alert("Discard changes?", isPresented: $isShowingDismissConfirmation) {
                    Button("Discard") {
                        recipe = originalRecipe
                        dismiss()
                    }
                    Button("Continue Editing") {}
                    Button("Save Changes") {
                        dismiss()
                    }
                }
        }
    }
    
    func storeOriginalRecipe() {
        originalRecipe = recipe
    }
    
    func addIngredient(){
        let newIngredient = Ingredient(name: newName, quantity: newQuantity ?? 0, unit: newUnit)
        recipe.ingredients.append(newIngredient)
        newName = ""
        newQuantity = nil
        newUnit = ""
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        @State var recipe = Recipe(name: "", ingredients: [])
        
        RecipeView(recipe: $recipe)
    }
}
