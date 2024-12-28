//
//  RecipeImageRepository.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 23/12/24.
//

import Foundation

protocol RecipeImageRepositoryType {
    func getImage(url: URL?) async -> Result<Data, DataError>
}

class RecipeImageRepository: RecipeImageRepositoryType {
    
    private let imageCache: ImageCacheType
    private let remoteImageDataService: RemoteImageDataServiceType
    
    init(imageCache: ImageCacheType, remoteImageDataService: RemoteImageDataServiceType) {
        self.imageCache = imageCache
        self.remoteImageDataService = remoteImageDataService
    }
    
    
    func getImage(url: URL?) async -> Result<Data, DataError> {
        guard let url = url else {
            return .failure(.URLError)
        }
        
        // Trying to get image from the cache
        if let cacheImage = await imageCache.getImageFromCache(forKey: url.absoluteString) {
           
            return .success(cacheImage)
        }
        
        // Trying to get image from remote service
        let remoteResult = await remoteImageDataService.requestImage(url: url)
        
        switch remoteResult {
        case .success(let data):
            // Saving downloaded image
            await imageCache.saveImageToCache(data, forKey: url.absoluteString)
            return .success(data)
        case .failure(let error):
            return .failure(error) 
        }
    }

    
}


