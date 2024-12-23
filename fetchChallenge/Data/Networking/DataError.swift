//
//  DataError.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 16/12/24.
//

import Foundation

//enum DataError: Error {
//  
//    
//    case URLError
//    case networkError
//    case apiError
//    case dataError
//    case decodingError
//    case emptyData
//    case otherError(Error)
//}

enum DataError: Error {
    case URLError
    case networkError
    case apiError
    case dataError
    case decodingError
    case emptyData
    case otherError(Error)
    
    var localizedDescription: String {
        switch self {
        case .URLError:
            return "URL is invalid."
        case .networkError:
            return "Network error occurred."
        case .apiError:
            return "API responded with an error."
        case .dataError:
            return "Data is corrupted or invalid."
        case .decodingError:
            return "Error decoding the data."
        case .emptyData:
            return "There are no recipes available. Try again later"
        case .otherError(let error):
            return "An unexpected error occurred: \(error.localizedDescription)"
        
        }
    }
}
