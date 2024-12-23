//
//  Recipe.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 18/12/24.
//

import Foundation

struct RecipeResponse: Codable {
    let recipes: [RecipeDTO?]
    
    enum CodingKeys: String, CodingKey {
        case recipes
    }
}

struct RecipeDTO: Codable, Hashable {
    let cuisine: String
    let name: String
    let photoUrlLarge: String
    let photoUrlSmall: String
    let uuid: String
    let sourceUrl: String?
    let youTubeUrl: String?

    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case uuid
        case sourceUrl = "source_url"
        case youTubeUrl = "youtube_url"
    }
}





