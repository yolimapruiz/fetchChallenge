//
//  URLSessionRequestMaker.swift
//  fetchChallenge
//
//  Created by Yolima Pereira Ruiz on 17/12/24.
//

import Foundation

struct URLSessionRequestMaker {
    func url(endpoint: String, baseURL: String) -> URL? {
        let urlstring = "\(baseURL)\(endpoint)"
        return URL(string: urlstring)
    }
}
