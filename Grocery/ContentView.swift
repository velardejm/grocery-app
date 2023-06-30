//
//  ContentView.swift
//  Grocery
//
//  Created by JM Velarde on 6/26/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var envData = EnvData()
    let defaults = UserDefaults.standard
    
    var body: some View {
        TabView {
            RecipeListView().tabItem {
                Text("Recipes")
                Image(systemName: "list.bullet")
            }
            VStack {
                Button("Load Sample Data"){
                    let recipe = Recipe(
                        name: "Chicken Adobo",
                        ingredients: [
                            Ingredient(name: "chicken", quantity: 1, unit: "kg"),
                            Ingredient(name: "garlic", quantity: 1, unit: "clove"),
                            Ingredient(name: "onion", quantity: 1, unit: "pcs"),
                            Ingredient(name: "soy sauce", quantity: 100, unit: "ml"),
                            Ingredient(name: "vinegar", quantity: 50, unit: "ml"),
                        ])
                    envData.recipeList.append(recipe)
                }
                
                Button("Save Data") {
                    let encoder = JSONEncoder()
                    if let data = try? encoder.encode(envData) {
                        defaults.set(data, forKey: "Data")
                    }
                }
                
                Button("Load Data") {
                    Task {
                        do {
                            try await loadData()
                        } catch {
                            print("An error occurred")
                        }
                    }
                }
            }.tabItem {
                Text("Load Sample Data")
                Image(systemName: "exclamationmark.triangle")
            }
            TestView().tabItem {
                Text("Test View")
                Image(systemName: "exclamationmark.triangle")
            }
        }.environmentObject(envData)
            .task {
                do {
                    try await loadData()
                } catch {
                    print("An error occurred")
                }
        }
            
    }
    
    func loadData() async throws {
        if let loadedData = defaults.object(forKey: "Data") as? Data {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(EnvData.self, from: loadedData) {
                envData.recipeList = decoded.recipeList
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
