//
//  DataError.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 16/12/24.
//

import Foundation
enum DataError: Error {
    case URLError
    case networkError
    case apiError
    case dataError
    case decodingError
    case emptyData
    case otherError(Error)
}
