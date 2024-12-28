//
//  RecipeListFactory.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 20/12/24.
//

import Foundation

class RecipeListFactory {
    @MainActor
    static func create() -> ContentView {
        return ContentView(viewModel: createRecipeViewModel())
        
    }
    
    @MainActor private static func createRecipeViewModel() -> RecipesViewModel {
        return RecipesViewModel(repository: createRecipeListRepository(),
                                imageRepository: createImageRepository())
    }
    
    private static func createImageRepository() -> RecipeImageRepositoryType {
        return RecipeImageRepository(imageCache: createImageCache(),
                                     remoteImageDataService: createURLSessionHTTPClient())
        
    }
    
    
    private static func createImageCache() -> ImageCacheType {
        return ImageCache()
    }
    
    private static func createRecipeListRepository() -> RecipeListRepositoryType {
        return RecipeListRepository(dataSource: createApiDataSource(),
                                    recipeMapper: RecipeMapper(),
                                    cacheDataSource: createCacheDataSource())
    }
    
    private static func createCacheDataSource() -> RecipeListCacheType {
        return RecipeListCache()
    }
    
    
    private static func createApiDataSource() -> ApiDataSource {
     
        return ApiDataSource(httpClient: createURLSessionHTTPClient())
    }
    
    private static func createURLSessionHTTPClient() -> URLSessionHTTPClient {
        return URLSessionHTTPClient(requestMaker: URLSessionRequestMaker())
    }
}
