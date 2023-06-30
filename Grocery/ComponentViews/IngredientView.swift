//
//  TestTextFieldsView.swift
//  Grocery
//
//  Created by JM Velarde on 6/28/23.
//

import SwiftUI

enum FocusedField: Hashable {
    case name, quantity, unit
}

struct IngredientView: View {
    
    @Binding var ingredient: Ingredient
    @FocusState private var focusedField: FocusedField?
    
    let availableWidth:Double
    let horizontalWidthSpace = 0.95
    let fieldnameWidth = 0.6
    let fieldquantityWidth = 0.2
    let fieldunitWidth = 0.2
    
    var body: some View {
            
                HStack {
                    TextField("Name", text: $ingredient.name)
                        .frame(width: availableWidth * horizontalWidthSpace * fieldnameWidth)
                        .focused($focusedField, equals: .name)
                        .textFieldStyle(MyTextFieldStyle(isFocused: focusedField == .name ))
                    
                    TextField("Quantity", value: $ingredient.quantity, format: .number)
                        .frame(width: availableWidth * horizontalWidthSpace * fieldquantityWidth)
                        .focused($focusedField, equals: .quantity)
                        .textFieldStyle(MyTextFieldStyle(isFocused: focusedField == .quantity ))
                    
                    TextField("Unit", text: $ingredient.unit)
                        .frame(width: availableWidth * horizontalWidthSpace * fieldunitWidth)
                        .focused($focusedField, equals: .unit)
                        .textFieldStyle(MyTextFieldStyle(isFocused: focusedField == .unit ))
                }.frame(maxWidth: availableWidth)
            
    }
}

struct TestTextFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        @State var ingredient = Ingredient(name: "", quantity: 0, unit: "")
        IngredientView(ingredient: $ingredient, availableWidth: 100)
    }
}
