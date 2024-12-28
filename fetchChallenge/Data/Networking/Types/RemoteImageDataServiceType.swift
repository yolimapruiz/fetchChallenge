//
//  RemoteImageDataService.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 23/12/24.
//

import Foundation

protocol RemoteImageDataServiceType {
    func requestImage(url: URL) async -> Result<Data, DataError>
}

