//
//  Recipe.swift
//  Grocery
//
//  Created by JM Velarde on 6/26/23.
//

import Foundation

struct Recipe: Identifiable, Codable, Equatable {    
    var id: Int
    var name: String
    var ingredients: [Ingredient]   
}
