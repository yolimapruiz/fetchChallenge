//
//  RecipeListRepository.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 19/12/24.
//

import Foundation

protocol RecipeListRepositoryType {
    func getRecipeList() async -> Result<[Recipe], DataError>
}


class RecipeListRepository: RecipeListRepositoryType {
    private let dataSource: ApiDatasourceType
    private let recipeMapper: RecipeMapper
    private let cacheDataSource: RecipeListCacheType
    
    init(dataSource: ApiDatasourceType, recipeMapper: RecipeMapper, cacheDataSource: RecipeListCacheType) {
        self.dataSource = dataSource
        self.recipeMapper = recipeMapper
        self.cacheDataSource = cacheDataSource
        
    }
    
    func getRecipeList() async -> Result<[Recipe], DataError> {
        
        let cacheRecipeList = await cacheDataSource.getRecipeList()
        
        if !cacheRecipeList.isEmpty {
            return .success(cacheRecipeList)
        }
        
        let result = await dataSource.getRecipesList()
        
        switch result {
            
        case .success(let recipeDTOs):
            let mappedRecipes = recipeDTOs.map{
                recipeMapper.map(dto: $0)}
            
            await cacheDataSource.saveRecipeList(mappedRecipes)
            return .success(mappedRecipes)
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
