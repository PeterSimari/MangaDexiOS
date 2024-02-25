//
//  MangaViewModel.swift
//  Manga
//
//  Created by Peter Simari on 1/16/24.
//

import Foundation
import SwiftUI

final class MangaViewModel: ObservableObject {
    
    @Published var manga: MangaResponse?
    @Published var manyMangas: MangasResponse?
    @Published var staffPicks: ListResponse?
    
    @Published var hasError: Bool = false
    @Published var error: MangaError?
    
    func fetchManga(_ id: String) {
        guard let request = NetworkCall.makeURLRequest(endpoint: .manga,
                                                       query: "\(id)") else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let mangasResponse = try JSONDecoder().decode(MangaResponse.self, from: data)
                DispatchQueue.main.async {
                    self.manga = mangasResponse
                }
            } catch {
                print("Error decoding JSON")
            }
        }.resume()
    }
    
    func fetchManyManga(_ ids: [String]) {
        var idURL: String = "?"
        for id in ids {
            idURL.append("ids[]\(id)&")
        }
        guard let request = NetworkCall.makeURLRequest(endpoint: .manga,
                                                       query: "\(idURL)") else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let mangasResponse = try JSONDecoder().decode(MangasResponse.self, from: data)
                DispatchQueue.main.async {
                    self.manyMangas = mangasResponse
                }
            } catch {
                print("Error decoding JSON")
            }
        }.resume()
    }
    
    func fetchStaffPicks() {
        guard let request = NetworkCall.makeURLRequest(endpoint: .list,
                                                       query: "805ba886-dd99-4aa4-b460-4bd7c7b71352") else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let mangasResponse = try JSONDecoder().decode(ListResponse.self, from: data)
                DispatchQueue.main.async {
                    self.staffPicks = mangasResponse
                }
            } catch {
                print("Error decoding JSON")
            }
        }.resume()
    }

}

extension MangaViewModel {
    // This will be used to convert data into something that we can read
    
    func listToMangaArray(relationships: [MangaListRelationship]) {
        var mangaIDs: [String] = []
        for relationship in relationships {
            if relationship.type == "manga" {
                mangaIDs.append(relationship.id ?? "")
            }
        }
        // Call the fetchManga which takes in multiple manga IDs (need new model for this)
        fetchManyManga(mangaIDs)
    }
}

extension MangaViewModel {
    // This will be used to turn data into something we want to display to the user
    
    func getTags(manga: Manga) -> [String] {
        var tagArray: [String] = []
        for tag in manga.attributes?.tags ?? [] {
            tagArray.append(tag.attributes?.name?.en ?? "")
        }
        return tagArray
    }
    
    func getSplitDescription(manga: Manga) -> String {
        let description: String = manga.attributes?.description?.en ?? ""
        let descriptionSplit = description.components(separatedBy: "\n")
        return descriptionSplit[0]
    }
}

extension MangaViewModel {
    enum MangaError: Error {
        case custom(error: Error)
        case failedToDecode
        case invalidURL
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .invalidURL:
                return "URL is not correct"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
