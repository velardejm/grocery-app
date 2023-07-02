//
//  IngredientView.swift
//  Grocery
//
//  Created by JM Velarde on 7/2/23.
//

import SwiftUI

struct IngredientView: View {
    @Binding var ingredient: Ingredient
    @Binding var editEnabled: Bool
    @State private var ingrEditMode = false
    
    private var ingredientDesccriptionView: some View {
        return Group {
            Text("\(ingredient.name.capitalized)")
            Spacer()
            Text("\(ingredient.quantity, specifier: "%.1f") \(ingredient.unit)")
        }
    }
    
    var body: some View {
        HStack {
            if !editEnabled {
                ingredientDesccriptionView
            }
            
            if editEnabled {
                
                if ingrEditMode {
                    IngredientEditView(ingredient: $ingredient)
                } else {
                    ingredientDesccriptionView
                }
                
                Button {
                    ingrEditMode.toggle()
                } label: {
                    Label("Edit", systemImage: ingrEditMode ? "checkmark.square" : "square.and.pencil")
                        .labelStyle(.iconOnly)
                        .foregroundColor(ingrEditMode ? .green : .blue)
                }
            }
        }
    }
}

//struct IngredientView_Previews: PreviewProvider {
//    static var previews: some View {
//        @State var ingredient = Ingredient(id: 1, name: "", quantity: 1, unit: "")
//        @State var ingrEditMode = false
//        IngredientView(ingredient: $ingredient)
//    }
//}
