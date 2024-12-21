//
//  Mocks.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 19/12/24.
//

import Foundation

let recipeMock = Recipe(id: "1234",
                      name: "Apam Balik",
                      cuisine: "Malaysian",
                      photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")


let recipesMock = [
    
    Recipe(id: "1234",
                         name: "Apam Balik",
                         cuisine: "Malaysian",
                         photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
    
    Recipe(id: "4567",
                         name: "Apam Balik",
                         cuisine: "Malaysian",
                         photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
    
    Recipe(id: "8910",
                         name: "Apam Balik",
                         cuisine: "Malaysian",
                         photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
    
    Recipe(id: "11121314",
                         name: "Apam Balik",
                         cuisine: "Malaysian",
                         photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
    
    Recipe(id: "14161718",
                         name: "Apam Balik",
                         cuisine: "Malaysian",
                         photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
    
    Recipe(id: "19202122",
                         name: "Apam Balik",
                         cuisine: "Malaysian",
                         photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
    
    Recipe(id: "23242526",
                         name: "Apam Balik",
                         cuisine: "Malaysian",
                         photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
    
    Recipe(id: "27282930",
                         name: "Apam Balik",
                         cuisine: "Malaysian",
                         photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
]

@MainActor let ContentViewModelMock = RecipesViewModel(repository: RecipeListRepository(dataSource: ApiDataSource(httpClient: URLSessionHTTPClient(requestMaker: URLSessionRequestMaker())), recipeMapper: RecipeMapper(), cacheDataSource: RecipeListCache()))
