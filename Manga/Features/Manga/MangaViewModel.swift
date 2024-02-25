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
    @Published var mangaCover: MangaCoverResponse?
    
    @Published var hasError: Bool = false
    @Published var error: MangaError?
    
    func fetchManga(_ id: String) {
        let mangaURL: String = "https://api.mangadex.dev/manga/\(id)"
        if let url: URL = URL(string: mangaURL) {
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    DispatchQueue.main.async {
                        if let error = error {
                            self?.hasError = true
                            self?.error = MangaError.custom(error: error)
                        } else {
                            let decoder: JSONDecoder = JSONDecoder()
                            
                            if let data = data,
                               let manga = try? decoder.decode(MangaResponse.self, from: data) {
                                self?.manga = manga
                            } else {
                                self?.hasError = true
                                self?.error = MangaError.failedToDecode
                            }
                        }
                    }
                }.resume()
        }
    }
    
    func fetchManyManga(_ ids: [String]) {
        var idURL: String = "?"
        for id in ids {
            idURL.append("ids[]\(id)&")
        }
        let mangaURL: String = "https://api.mangadex.dev/manga/\(idURL)"
        if let url: URL = URL(string: mangaURL) {
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    DispatchQueue.main.async {
                        if let error = error {
                            self?.hasError = true
                            self?.error = MangaError.custom(error: error)
                        } else {
                            let decoder: JSONDecoder = JSONDecoder()
                            
                            if let data = data,
                               let manga = try? decoder.decode(MangasResponse.self, from: data) {
                                self?.manyMangas = manga
                            } else {
                                self?.hasError = true
                                self?.error = MangaError.failedToDecode
                            }
                        }
                    }
                }.resume()
        }
    }
    
    func fetchMangaCoverData(_ mangaInfo: Manga) {
        var mangaCoverID: String = ""
        for relationships in mangaInfo.relationships ?? [] {
            if relationships.type == "cover_art" {
                mangaCoverID = relationships.id
            }
        }
        let mangaCoverURL: String = "https://api.mangadex.dev/cover/\(mangaCoverID)"
        guard let url: URL = URL(string: mangaCoverURL) else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("petis API Client - MangaDEX iOS App",
                         forHTTPHeaderField: "User-Agent")
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.hasError = true
                    self?.error = MangaError.custom(error: error)
                } else {
                    let decoder: JSONDecoder = JSONDecoder()
                    if let data = data,
                       let mangaCover = try? decoder.decode(MangaCoverResponse.self, from: data) {
                        self?.mangaCover = mangaCover
                    } else {
                        self?.hasError = true
                        self?.error = MangaError.failedToDecode
                    }
                }
            }
        }.resume()
    }
    
    func fetchMangaCover(_ mangaInfo: Manga) -> String {
        fetchMangaCoverData(mangaInfo)
        return "https://uploads.mangadex.dev/covers/\(mangaInfo.id)/\(mangaCover?.data?.attributes?.fileName ?? "")"
    }
    
    func fetchStaffPicks() {
        let url: String = "https://api.mangadex.dev/list/805ba886-dd99-4aa4-b460-4bd7c7b71352?includes[]=user"
        if let url: URL = URL(string: url) {
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    DispatchQueue.main.async {
                        if let error = error {
                            self?.hasError = true
                            self?.error = MangaError.custom(error: error)
                        } else {
                            let decoder: JSONDecoder = JSONDecoder()
                            
                            if let data = data,
                               let manga = try? decoder.decode(ListResponse.self, from: data) {
                                self?.staffPicks = manga
                                self?.listToMangaArray(relationships: manga.data?.relationships ?? [])
                                // convert the array of relationships who's type is Manga to [Manga] in a new function
                                // iterate through that list when calling this.
                            } else {
                                self?.hasError = true
                                self?.error = MangaError.failedToDecode
                            }
                        }
                    }
                }.resume()
        }
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
