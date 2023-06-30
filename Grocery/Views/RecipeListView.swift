//
//  RecipeListView.swift
//  Grocery
//
//  Created by JM Velarde on 6/26/23.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var envData: EnvData
    
     
    var body: some View {
        
        NavigationView {
            List {
                ForEach($envData.recipeList) {$recipe in
                    NavigationLink {
                        RecipeView(recipe: $recipe)
                    } label: {
                        Text(recipe.name)
                    }
                }
            }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
