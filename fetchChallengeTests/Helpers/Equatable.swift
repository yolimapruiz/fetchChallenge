//
//  Equatable.swift
//  fetchChallengeTests
//
//  Created by Yolima Pereira Ruiz on 21/12/24.
//

import Foundation
@testable import fetchChallenge

extension Recipe: @retroactive Equatable {
    public static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.cuisine == rhs.cuisine
        && lhs.photoUrl == rhs.photoUrl
    }
    
}

extension DataError: @retroactive Equatable {
    public static func == (lhs: DataError, rhs: DataError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
}
//extension RecipeDTO: @retroactive Equatable {
//    public static func == (lhs: RecipeDTO, rhs: RecipeDTO) -> Bool {
//        lhs.name == rhs.name
//        && lhs.cuisine == rhs.cuisine
//        && lhs.photoUrlSmall == rhs.photoUrlSmall
//        && lhs.photoUrlLarge == rhs.photoUrlLarge
//        && lhs.uuid == rhs.uuid
//        && lhs.sourceUrl == rhs.sourceUrl
//        && lhs.youTubeUrl == rhs.youTubeUrl
//    }
//}


