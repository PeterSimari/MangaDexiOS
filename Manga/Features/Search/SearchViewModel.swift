//
//  SearchViewModel.swift
//  Manga
//
//  Created by Peter Simari on 2/24/24.
//

import Foundation
import SwiftUI

final class SearchViewModel: ObservableObject {
    @Published var mangas: MangasResponse?
    var limit: Int
    var endpoint: String
    
    init(mangas: MangasResponse? = nil) {
        self.mangas = mangas
        self.limit = 10
        self.endpoint = "limit=\(limit)"
    }
    
    
    func searchManga(withTitle title: String) {
        guard let request = NetworkCall.makeURLRequest(endpoint: .search,
                                                       query: "\(endpoint)&title=\(title)&includes[]=author&includes[]=artist&includes[]=cover_art") else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let mangasResponse = try JSONDecoder().decode(MangasResponse.self, from: data)
                DispatchQueue.main.async {
                    self.mangas = mangasResponse
                }
            } catch {
                print("Error decoding JSON")
            }
        }.resume()
    }
}


