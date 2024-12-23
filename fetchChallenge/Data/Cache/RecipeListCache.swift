//
//  RecipeListCache.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 20/12/24.
//

import Foundation

class RecipeListCache: RecipeListCacheType {
    private let recipeListKey = "recipeList"
    
    func getRecipeList() async -> [Recipe] {
        if let data = UserDefaults.standard.data(forKey: recipeListKey) {
            let decoder = JSONDecoder()
            if let recipeList = try? decoder.decode([Recipe].self, from: data) {
              
                return recipeList
            }
        }
        
        return []
    }
    
    func saveRecipeList(_ recipeList: [Recipe]) async {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(recipeList) {
            UserDefaults.standard.set(data, forKey: recipeListKey)
            
        }
    }
    
   
}
