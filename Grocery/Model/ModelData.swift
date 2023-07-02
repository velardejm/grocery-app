//
//  ModelData.swift
//  Grocery
//
//  Created by JM Velarde on 7/2/23.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var recipes: [Recipe] = load("recipes.json")
}

func load<T: Codable> (_ filename: String) -> T {
    let data: Data
    
    guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Cannot get url of \(filename)")
    }
    
    do {
       data = try Data(contentsOf: url)
    } catch {
        fatalError("\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("\(error)")
    }
    
}
