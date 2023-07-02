//
//  RecipeListView.swift
//  Grocery
//
//  Created by JM Velarde on 6/26/23.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var modelData: ModelData
     
    var body: some View {
        
        NavigationView {
            List {
                ForEach($modelData.recipes) {$recipe in
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
        RecipeListView().environmentObject(ModelData())
    }
}
