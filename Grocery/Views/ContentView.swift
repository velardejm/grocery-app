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
            TestView().tabItem {
                Text("Test View")
                Image(systemName: "exclamationmark.triangle")
            }
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
