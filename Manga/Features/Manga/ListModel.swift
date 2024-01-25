//
//  ListModel.swift
//  Manga
//
//  Created by Peter Simari on 1/17/24.
//

import Foundation

struct ListResponse: Codable {
    let result: String?
    let response: String?
    let data: MangaList?
}

struct MangaList: Codable, Identifiable {
    let id: String?
    let type: String?
    let attributes: MangaListAttributes?
    let relationships: [MangaListRelationship]?
}

struct MangaListAttributes: Codable {
    let name: String?
    let visibility: String?
    let version: Int?
}

struct MangaListRelationship: Codable, Identifiable {
    let id: String?
    let type: String?
    let related: String?
    let attributes: MangaListRelationshipAttributes?
}

struct MangaListRelationshipAttributes: Codable {
    
}
