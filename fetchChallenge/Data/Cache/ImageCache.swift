//
//  ImageCache.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 23/12/24.
//

import Foundation

actor ImageCache: ImageCacheType {
    private let memoryCache = NSCache<NSString, NSData>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL

    init() {
        // Cache directory in disk
        cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("ImageCache")
        
        // Create the directory if it did not exist
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        }
        
    }
    
   //getting image from the cache
    func getImageFromCache(forKey key: String) async -> Data? {
        let safeKey = makeSafeKey(key)
        let cacheKey = NSString(string: safeKey)
        
        // Searching in memory chache
        if let cachedData = memoryCache.object(forKey: cacheKey) {
            
            return cachedData as Data
        }
        
        // Searching in disk
        let filePath = cacheDirectory.appendingPathComponent(safeKey)
        
        
        guard fileManager.fileExists(atPath: filePath.path) else {
            
            return nil
        }
        
        do {
            let data = try Data(contentsOf: filePath)
            memoryCache.setObject(data as NSData, forKey: cacheKey)
            
            return data
        } catch {
            print("ERROR: Could not read image from disk with the key \(safeKey): \(error)")
            return nil
        }
    }

    //Save image in cache
    func saveImageToCache(_ data: Data, forKey key: String) async {
        let safeKey = makeSafeKey(key)
        let cacheKey = NSString(string: safeKey)
        
        //Saving in local memory
        memoryCache.setObject(data as NSData, forKey: cacheKey)
        
        // Saving in disk
        let filePath = cacheDirectory.appendingPathComponent(safeKey)
        do {
            try data.write(to: filePath)
            
        } catch {
            print("ERROR: Could not save image for the key \(safeKey): \(error)")
        }
    }

    //creating a save key
    private func makeSafeKey(_ key: String) -> String {
        return key.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? key
    }
}
