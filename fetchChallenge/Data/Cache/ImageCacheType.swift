//
//  File.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 23/12/24.
//

import Foundation

protocol ImageCacheType {
   func getImageFromCache(forKey key: String) async -> Data?
   func saveImageToCache(_ data: Data, forKey key: String) async
}
