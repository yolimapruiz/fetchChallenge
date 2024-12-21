//
//  HTTPClientType.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 16/12/24.
//

import Foundation

protocol HTTPClientType {
    func makeRequest(endpoint: String, baseUrl: String) async -> Result<Data, DataError>
}
