//
//  Recipe.swift
//  Grocery
//
//  Created by JM Velarde on 6/26/23.
//

import Foundation

struct Recipe: Identifiable, Codable, Equatable {    
    var id: UUID
    var name: String
    var ingredients: [Ingredient]   
}

struct Ingredient: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var quantity: Double
    var unit: String
}
