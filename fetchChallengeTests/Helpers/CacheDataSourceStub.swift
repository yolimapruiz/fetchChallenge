//
//  CacheDataSourceStub.swift
//  fetchChallengeTests
//
//  Created by Yolima Pereira Ruiz on 21/12/24.
//

import Foundation
@testable import fetchChallenge

class CacheDataSourceStub: RecipeListCacheType {
    
    private let getRecipeList: [Recipe]
    var cachedRecipeList: [Recipe]?
    
    init(getRecipeList: [Recipe]) {
        self.getRecipeList = getRecipeList
       
    }
    
    func getRecipeList() async -> [Recipe] {
        return getRecipeList
    }
    
    func saveRecipeList(_ recipeList: [Recipe]) async {
        cachedRecipeList = recipeList
    }
    
    
}
