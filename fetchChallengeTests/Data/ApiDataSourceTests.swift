//
//  ApiDataSourceTests.swift
//  fetchChallengeTests
//
//  Created by Yolima Pereira Ruiz on 21/12/24.
//

import XCTest
@testable import fetchChallenge

final class ApiDataSourceTests: XCTestCase {
    
    func test_getRecipesList_sucesses_when_httpClient_request_sucesses_and_response_is_correct() async throws {
        
        //Given
        
        let data: Data? = """
      {
        "recipes": [
          {
            "cuisine": "Malaysian",
            "name": "Apam Balik",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
            "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
          },
          {
            "cuisine": "British",
            "name": "Apple & Blackberry Crumble",
            "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
            "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
            "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
            "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
            "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
          }
        ]
      }
      """.data(using: .utf8)
        
        let expectedResult: [RecipeDTO] = [
            .init(cuisine: "Malaysian",
                  name: "Apam Balik",
                  photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                  photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                  uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                  sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                  youTubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg"),
            
                .init(cuisine: "British",
                      name: "Apple & Blackberry Crumble",
                      photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                      photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                      uuid: "599344f4-3c5c-4cca-b914-2210e3b3312f",
                      sourceUrl: "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                      youTubeUrl: "https://www.youtube.com/watch?v=4vhcOwVBDO4")
            
        ]
        
        let sut = ApiDataSource(httpClient: HTTPClientStub(result: .success(data!)))
        
        //When
        let capturedResult = await sut.getRecipesList()
       
        //Then
        let result = try XCTUnwrap(capturedResult.get())
    
        XCTAssertEqual(result, expectedResult)
        
    }
    
    func test_getRecipesList_fails_when_httpClient_request_sucesses_and_response_is_empty() async throws {
        
        //Given
        let data: Data? = """
                {
                "recipes": []
                }
                """.data(using: .utf8)
        
        let expectedResult: DataError = .emptyData
        
        let sut = ApiDataSource(httpClient: HTTPClientStub(result: .success(data!)))
        
        //When
        let capturedResult = await sut.getRecipesList()
        
        
        //Then
        guard case .failure(let result) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_getRecipesList_fails_when_httpClient_request_sucesses_and_response_is_malformed() async throws {
        
        //Given
        let data: Data? = """
      {
          "recipes": [
              {
                  "cuisine": "Malaysian",
                  "name": "Apam Balik",
                  "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                  "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                  "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                  "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                  "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
              },
              {
                  "cuisine": "British",
                  "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                  "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                  "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                  "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
                  "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
              }
              
          ]
      }
      """.data(using: .utf8)
        
        
        let expectedResult: DataError = .decodingError
        
        let sut = ApiDataSource(httpClient: HTTPClientStub(result: .success(data!)))
        
        //When
        let capturedResult = await sut.getRecipesList()
        
        
        //Then
        guard case .failure(let result) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }
      
        XCTAssertEqual(result, expectedResult)
    }
   
    func test_getRecipesList_fails_when_httpClient_request_successes_and_data_is_corrupted() async throws {
        
        //Given
        let expectedResult: DataError = .dataError
        let sut = ApiDataSource(httpClient: HTTPClientStub(result: .failure(.dataError)))
        
        //When
        
        let capturedResult = await sut.getRecipesList()
        
        
        //Then
        guard case .failure(let result) = capturedResult else {
            XCTFail("Expected failure, got success")
            return
        }
      
        XCTAssertEqual(result, expectedResult)
    }

}
