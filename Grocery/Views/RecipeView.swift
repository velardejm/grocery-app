//
//  RecipeView.swift
//  Grocery
//
//  Created by JM Velarde on 6/26/23.
//

import SwiftUI


struct RecipeView: View {
    @Binding var recipe: Recipe
    @State private var dataChanged = false
    @EnvironmentObject var envData: EnvData
    @Environment(\.dismiss) var dismiss
    @State private var originalRecipe = Recipe(id:1, name: "", ingredients: [])
    
    
    @State private var isShowingSaveConfirmation = false
    @State private var isShowingDismissConfirmation = false
    @State private var editIngredientsEnabled = false
    
    
    var body: some View {
        GeometryReader {geom in
            List {
                if (!editIngredientsEnabled) {
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
                
                if (editIngredientsEnabled) {
                    RecipeEditView(recipe: $recipe, dataChanged:$dataChanged , geom: geom)
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
                            if(!editIngredientsEnabled) {
                                editIngredientsEnabled = true
                            } else {
                                isShowingSaveConfirmation = true
                            }
                            
                            
                        } label: {
                            if !editIngredientsEnabled {Image(systemName: "square.and.pencil")}
                            if editIngredientsEnabled {
                                Image(systemName: "externaldrive.badge.checkmark")
                            }
                        }.disabled(!dataChanged && editIngredientsEnabled)
                            .alert("Save changes?",isPresented: $isShowingSaveConfirmation) {
                                Button("Save") {
                                    originalRecipe = recipe
                                    dataChanged = false
                                }
                                Button("Cancel") {}
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
    

}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        @State var recipe = Recipe(id:1, name: "", ingredients: [])
        
        RecipeView(recipe: $recipe)
    }
}
