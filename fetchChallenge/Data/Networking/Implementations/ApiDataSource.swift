//
//  ApiDataSource.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 18/12/24.
//

import Foundation

class ApiDataSource: ApiDatasourceType {
    
    private let httpClient : HTTPClientType
    private let baseUrl = "https://d3jbb8n5wk0qxi.cloudfront.net"
    
    init(httpClient: HTTPClientType) {
        self.httpClient = httpClient
    }
    
    func getRecipesList() async -> Result<[RecipeDTO], DataError> {
       let endPoint = "/recipes.json"
      //  let endPoint = "/recipes-empty.json"
     //  let endPoint = "/recipes-malformed.json"
        
        let result = await httpClient.makeRequest(endpoint: endPoint, baseUrl: baseUrl)
        
        guard case .success(let data) = result else {
            return .failure(.dataError)
        }
        
        guard let recipesList = try? JSONDecoder().decode(RecipeResponse.self, from: data) else {
            return .failure(.decodingError)
        }
        
        
        let validRecipeList = recipesList.recipes.compactMap { $0 }
        
        guard !validRecipeList.isEmpty else {
            return .failure(.emptyData)
        }
        
        return .success(validRecipeList.sorted(by: { $0.name < $1.name}))
        
    }
    
}
