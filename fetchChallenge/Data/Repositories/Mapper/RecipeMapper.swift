//
//  RecipeMapper.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 19/12/24.
//

import Foundation

struct RecipeMapper {
    func map(dto: RecipeDTO) -> Recipe {
       
        
        return Recipe(id: dto.uuid,
                      name: dto.name,
                      cuisine: dto.cuisine,
                      photoUrl: dto.photoUrlSmall)
    }
}
