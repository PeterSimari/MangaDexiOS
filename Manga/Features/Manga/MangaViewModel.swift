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
                                                       query: "\(id)?includes[]=artist&includes[]=cover_art") else {
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
    // This will be used to convert data into something that we can interperet
    
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
    
    func generateCoverURL(manga: Manga) -> String {
        let baseURL: String = "https://uploads.mangadex.dev/covers/"
        return "\(baseURL)\(manga.id)/\(getCoverURL(manga: manga))"
    }
    
    private func getCoverURL(manga: Manga) -> String {
        for relationship in manga.relationships ?? [] {
            if relationship.type == "cover_art" {
                return relationship.attributes?.fileName ?? ""
            }
        }
        return ""
    }
}

extension MangaViewModel {
    // This will be used to turn data into something we want to display to the user
    // This is all to compensate for the god awful job i did setting up my model...
    // Maybe i'll learn when i have to refactor it all down the line for something
    
    // MARK: Title & Artist Functions
    
    func getTitle(_ manga: Manga) -> String {
        return manga.attributes?.title?.en ?? ""
    }
    
    func getShortTitle(_ manga: Manga) -> String {
        let title: String = manga.attributes?.title?.en ?? ""
        let titleSplit = title.components(separatedBy: "-")
        return titleSplit[0]
    }
    
    func getArtistName(_ manga: Manga) -> String {
        for relationship in manga.relationships ?? [] {
            if relationship.type == "artist" {
                return relationship.attributes?.name ?? ""
            }
        }
        return ""
    }
    
    // MARK: Description Functions
    
    func getFullDescription(_ manga: Manga) -> String {
        return manga.attributes?.description?.en ?? ""
    }
    
    func getDescriptionPreDash(_ manga: Manga) -> String {
        let description: String = manga.attributes?.description?.en ?? ""
        let descriptionSplit = description.components(separatedBy: "---")
        return descriptionSplit[0]
    }
    
    func getDescriptionPreDash(_ manga: Manga) -> [String] {
        let description: String = manga.attributes?.description?.en ?? ""
        return description.components(separatedBy: "---")
    }
    
    func getSplitDescription(_ manga: Manga) -> String {
        let description: String = manga.attributes?.description?.en ?? ""
        let descriptionSplit = description.components(separatedBy: "\n")
        return descriptionSplit[0]
    }
    
    func getSplitDescription(_ manga: Manga) -> [String] {
        let description: String = manga.attributes?.description?.en ?? ""
        return description.components(separatedBy: "\n")
    }
    
    // MARK: Status, Demographic, Rating Functions
    
    func getStatus(_ manga: Manga) -> String {
        manga.attributes?.status ?? ""
    }
    
    func getDemographic(_ manga: Manga) -> String {
        manga.attributes?.publicationDemographic ?? ""
    }
    
    func getRating(_ manga: Manga) -> String {
        manga.attributes?.contentRating ?? ""
    }
    
    // MARK: Original Language Functions
    
    func getOriginalLanguage(manga: Manga) -> String {
        manga.attributes?.originalLanguage ?? ""
    }
    
    // MARK: Tag Functions
    
    func getTags(manga: Manga) -> [String] {
        var tagArray: [String] = []
        for tag in manga.attributes?.tags ?? [] {
            tagArray.append(tag.attributes?.name?.en ?? "")
        }
        return tagArray
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
