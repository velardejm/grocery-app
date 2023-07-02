//
//  TestView.swift
//  Grocery
//
//  Created by JM Velarde on 6/28/23.
//

import SwiftUI


struct Person: Equatable {
    let name: String
}


struct TestView: View {
    
    @State private var text = ""
    let person1 = Person(name: "One")
    let person2 = Person(name: "One")
    
    var body: some View {
        
        VStack {
            Button("Check Equality") {
                if (person1 == person2) {
                    print("Equal")
                }
                
            }
        }
        
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
