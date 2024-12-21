//
//  ApiDataSourceStub.swift
//  fetchChallengeTests
//
//  Created by Yolima Pereira Ruiz on 21/12/24.
//

import Foundation
@testable import fetchChallenge

class apiDataSourceStub {
    private let recipeList: Result<[RecipeDTO], DataError>
    
    init(recipeList: Result<[RecipeDTO], DataError>) {
        self.recipeList = recipeList
    }
    
}

extension apiDataSourceStub: ApiDatasourceType {
    func getRecipesList() async -> Result<[RecipeDTO], DataError> {
        return recipeList
    }
    
    
}
