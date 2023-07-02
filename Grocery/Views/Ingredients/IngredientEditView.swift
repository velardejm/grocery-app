//
//  IngredientEditView.swift
//  Grocery
//
//  Created by JM Velarde on 7/2/23.
//

import SwiftUI

enum FocusedField: Hashable {
    case name, quantity, unit
}

struct IngredientEditView: View {
    @Binding var ingredient: Ingredient
    
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        GeometryReader {geom in
            HStack {
                TextField("Name", text: $ingredient.name).frame(width: geom.size.width * 0.5)
                    .focused($focusedField, equals: .name)
                    .textFieldStyle(MyTextFieldStyle(isFocused: focusedField == .name))
                    //.textFieldStyle(.roundedBorder)
                
                TextField("Quantity", value: $ingredient.quantity, format: .number).frame(width: geom.size.width * 0.2)
                    .focused($focusedField, equals: .quantity)
                    .textFieldStyle(MyTextFieldStyle(isFocused: focusedField == .quantity))
                
                TextField("Unit", text: $ingredient.unit).frame(width: geom.size.width * 0.2)
                    .focused($focusedField, equals: .unit)
                    .textFieldStyle(MyTextFieldStyle(isFocused: focusedField == .unit))
            }
        }
    }
}

struct IngredientEditView_Previews: PreviewProvider {
    static var previews: some View {
        @State var ingredient = Ingredient(id: UUID(), name: "", quantity: 1 , unit: "")
        IngredientEditView(ingredient: $ingredient)
    }
}
