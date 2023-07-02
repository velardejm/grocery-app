//
//  GroceryApp.swift
//  Grocery
//
//  Created by JM Velarde on 6/26/23.
//

import SwiftUI

@main
struct GroceryApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(modelData)
        }
    }
}
