//
//  RecipeCacheType.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 20/12/24.
//

import Foundation

protocol RecipeListCacheType {
    func getRecipeList() async -> [Recipe]
    func saveRecipeList(_ recipeList: [Recipe]) async 
}
