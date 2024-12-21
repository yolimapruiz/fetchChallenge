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
        
        let result = await httpClient.makeRequest(endpoint: endPoint, baseUrl: baseUrl)
        
        guard case .success(let data) = result else {
            return .failure(.dataError)
        }
        
        print("DEBUG : TENGO DATA")
        
        guard let recipesList = try? JSONDecoder().decode(RecipeResponse.self, from: data) else {
            return .failure(.decodingError)
        }
        
        return .success(recipesList.recipes.sorted(by: { $0.name ?? "" < $1.name ?? ""
        }))
        
        
        
        

    }
    
    
}
