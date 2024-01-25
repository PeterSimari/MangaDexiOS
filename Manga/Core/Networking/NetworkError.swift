//
//  NetworkError.swift
//  Manga
//
//  Created by Peter Simari on 1/6/24.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}
