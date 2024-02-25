//
//  NetworkCall.swift
//  Manga
//
//  Created by Peter Simari on 2/24/24.
//

import Foundation
import SwiftUI

public enum Environment: String {
    case prod = "org"
    case test = "dev"
    public static var env: Environment = .test
}

public class NetworkCall {
    
    public enum HttpMethod {
        case get, post
        
        func toString() -> String {
            switch self {
            case .get: return "GET"
            case .post: return "POST"
            }
        }
    }
    
    static private func createURLString() -> String {
        return "https://api.mangadex.\(Environment.env.rawValue)"
    }
    
    static func makeURLRequest(endpoint: Endpoint, query: String, httpMethod: HttpMethod = .get) -> URLRequest? {
        guard let url = URL(string: "\(createURLString())/\(endpoint.rawValue)\(query)") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
        switch httpMethod {
        case .get:
            request.httpMethod = httpMethod.toString()
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .post:
            request.httpMethod = httpMethod.toString()
        }
        // this is for an auth token if we ever need one (currently dont)
//        request.setValue("Bearer \(Token.token)", forHTTPHeaderField: "Authorization")
        request.setValue("petis API Client - MangaDEX iOS App",
                         forHTTPHeaderField: "User-Agent")
        
        return request
    }
}


