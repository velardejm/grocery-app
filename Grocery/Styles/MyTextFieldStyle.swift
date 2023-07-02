//
//  MyTextFieldStyle.swift
//  Grocery
//
//  Created by JM Velarde on 6/28/23.
//

import Foundation
import SwiftUI

//Custom TextField style
struct MyTextFieldStyle: TextFieldStyle {
    
    //let imageName: String
    var isFocused: Bool
    
    func _body(configuration:TextField<Self._Label>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3.5, style: .continuous)
                .stroke(isFocused ? .green : .gray, lineWidth: !isFocused ? 0.3 : 1)
                .frame(height: 35)
            
            HStack {
                configuration
            }.padding(.leading, 10)
            .foregroundColor(!isFocused ? .gray : .black)
        }
    }
}
