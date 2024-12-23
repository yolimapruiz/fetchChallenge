//
//  HTTPClientStub.swift
//  fetchChallengeTests
//
//  Created by Yolima Pereira Ruiz on 21/12/24.
//

import Foundation
@testable import fetchChallenge

class HTTPClientStub: HTTPClientType {
    
    let result: Result<Data, DataError>
    
    init(result: Result<Data, DataError>) {
        self.result = result
    }
    
    func makeRequest(endpoint: String, baseUrl: String) async -> Result<Data, DataError> {
        return result
    }
    
    
}
