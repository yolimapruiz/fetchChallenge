//
//  RecipeListFactory.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 20/12/24.
//

import Foundation

class RecipeListFactory {
    @MainActor static func create() -> ContentView {
        return ContentView(viewModel: createRecipeViewModel())
        
    }
    
    private static func createRecipeViewModel() -> RecipesViewModel {
        return RecipesViewModel(repository: createRecipeListRepository())
    }
    
    private static func createRecipeListRepository() -> RecipeListRepository {
        return RecipeListRepository(dataSource: createApiDataSource(), recipeMapper: RecipeMapper(), cacheDataSource: createCacheDataSource())
    }
    
    private static func createCacheDataSource() -> RecipeListCacheType {
        return RecipeListCache()
    }
    private static func createApiDataSource() -> ApiDataSource {
        let httpClient = URLSessionHTTPClient(requestMaker: URLSessionRequestMaker())
        return ApiDataSource(httpClient: httpClient)
    }
}
