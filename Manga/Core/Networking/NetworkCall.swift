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
    
    static private func createURLString() -> String {
        return "https://api.mangadex.\(Environment.env.rawValue)"
    }
    
    static func makeURLRequest(endpoint: String) -> URLRequest? {
        guard let url = URL(string: "\(createURLString())/\(endpoint)") else {
            return nil
        }
        
        var request = URLRequest(url: url)
        
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer (token)", forHTTPHeaderField: "Authorization")
        request.setValue("petis API Client - MangaDEX iOS App",
                         forHTTPHeaderField: "User-Agent")
        
        return request
    }
}


