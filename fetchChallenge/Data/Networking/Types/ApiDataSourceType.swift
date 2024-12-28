//
//  ApiDataSourceType.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 18/12/24.
//

import Foundation
protocol ApiDatasourceType {
    func getRecipesList() async -> Result<[RecipeDTO], DataError>
    
}
