//
//  File.swift
//  Grocery
//
//  Created by JM Velarde on 6/26/23.
//

import Foundation

struct Ingredient: Identifiable, Codable, Equatable {
    var id: Int
    var name: String
    var quantity: Double
    var unit: String
}
