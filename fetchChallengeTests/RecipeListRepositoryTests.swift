//
//  fetchChallengeTests.swift
//  fetchChallengeTests
//
//  Created by Yolima Pereira Ruiz on 16/12/24.
//

import XCTest
@testable import fetchChallenge

final class RecipeListRepositoryTests: XCTestCase {

    

    func test_getRecipeList_returns_success_when_cache_is_not_empty() async throws {
       //Given
        let expectedRecipeList = Recipe.makeRecipeList()
        
        let (sut, _) = makeSUT(apiDataSourceResult: .success([]),
                               cachedValue: expectedRecipeList)
        //When
        let result = await sut.getRecipeList()
        
        //Then
        
        let recipeList = try XCTUnwrap(result.get())
        
        XCTAssertEqual(recipeList, expectedRecipeList)
    }

    func test_getRecipeList_returns_success_when_the_cache_is_empty() async throws {
        //Given
        let expectedRecipeList = Recipe.makeRecipeList()
        let recipeDTO = RecipeDTO.makeRecipeList()
        
        let (sut, _) = makeSUT(apiDataSourceResult: .success(recipeDTO),
                               cachedValue: [])
        
        //When
        let result = await sut.getRecipeList()
        
        //Then
        let recipeList = try XCTUnwrap(result.get())
        XCTAssertEqual(recipeList, expectedRecipeList)
        
    }
    
    func test_getRecipeList_saves_in_cache_when_gets_data_from_apiDataSource() async throws {
        //Given
        let expectedRecipeList = Recipe.makeRecipeList()
        let recipeDTO = RecipeDTO.makeRecipeList()
        
        let (sut, cacheDatSource) = makeSUT(apiDataSourceResult: .success(recipeDTO),
                               cachedValue: [])
        
        //When
       _ = await sut.getRecipeList()
        
        //Then
        
        XCTAssertEqual(cacheDatSource.cachedRecipeList, expectedRecipeList)
        
    }
    
    func test_getRecipeList_returns_failure_when_URLError_when_the_cache_is_empty() async throws {
        
        //Given
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.URLError), cachedValue: [])
        //When
        
        let result = await sut.getRecipeList()
        //Then
        
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, DataError.URLError)

    }
    
    func test_getRecipeList_returns_failure_when_apiError_when_the_cache_is_empty() async throws {
        //Given
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.apiError), cachedValue: [])
        
        //When
        let result = await sut.getRecipeList()
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, DataError.apiError)
    }
    
    func test_getRecipeList_returns_failure_when_dataError_when_the_cache_is_empty() async throws {
        //Given
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.dataError), cachedValue: [])
        
        //When
        let result = await sut.getRecipeList()
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, DataError.dataError)
    }
    
    func test_getRecipeList_returns_failure_when_decodingError_when_the_cache_is_empty() async throws {
        //Given
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.decodingError), cachedValue: [])
        
        //When
        let result = await sut.getRecipeList()
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, DataError.decodingError)
    }
    
    func test_getRecipeList_returns_failure_when_networkError_when_the_cache_is_empty() async throws {
        //Given
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.networkError), cachedValue: [])
        
        //When
        let result = await sut.getRecipeList()
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, DataError.networkError)
    }
    
    func test_getRecipeList_returns_failure_when_emptyData_when_the_cache_is_empty() async throws {
        //Given
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.emptyData), cachedValue: [])
        
        //When
        let result = await sut.getRecipeList()
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, DataError.emptyData)
    }
    
    
    }
    
    private func makeSUT(apiDataSourceResult: Result<[RecipeDTO],DataError>,
                         cachedValue: [Recipe])
    -> (sut: RecipeListRepository, cache: CacheDataSourceStub) {
        let apiDataSource = apiDataSourceStub(recipeList: apiDataSourceResult)
        
        let cacheDataSource = CacheDataSourceStub(getRecipeList: cachedValue)
        
        let sut = RecipeListRepository(dataSource: apiDataSource, recipeMapper: RecipeMapper(), cacheDataSource: cacheDataSource)
        
        return(sut: sut, cache: cacheDataSource)
        
    }



extension Recipe {
    static func makeRecipeList() -> [Recipe] {
        return [
            .init(id: "1234",
                                 name: "Apam Balik",
                                 cuisine: "Malaysian",
                                 photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
            
                .init(id: "4567",
                                 name: "Pasta Carbonara",
                                 cuisine: "Italian",
                                 photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
            
                .init(id: "8910",
                                 name: "Pabellon",
                                 cuisine: "Venezuelan",
                                 photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
            
                .init(id: "11121314",
                                 name: "Ceviche",
                                 cuisine: "Peruvian",
                                 photoUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
            
        ]
    }
}

extension RecipeDTO {
    static func makeRecipeList() -> [RecipeDTO] {
        return [
            .init(cuisine: "Malaysian", name: "Apam Balik", photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", uuid: "1234", sourceUrl: "sourceURL", youTubeUrl: "youtubeURl"),
            
            .init(cuisine: "Italian", name: "Pasta Carbonara", photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", uuid: "4567", sourceUrl: "sourceURL", youTubeUrl: "youtubeURl"),
            
            
            .init(cuisine: "Venezuelan", name: "Pabellon", photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", uuid: "8910", sourceUrl: "sourceURL", youTubeUrl: "youtubeURl"),
            
                .init(cuisine: "Peruvian", name: "Ceviche", photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", uuid: "11121314", sourceUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg", youTubeUrl: "youtubeURL")
            
        ]
    }
}
