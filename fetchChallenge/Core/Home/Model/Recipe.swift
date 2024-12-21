//
//  Recipe.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 19/12/24.
//

import Foundation

struct Recipe: Codable, Identifiable {
    let id: String
    let name: String
    let cuisine: String
    let photoUrl: String
}

