//
//  MangaCoverModel.swift
//  Manga
//
//  Created by Peter Simari on 1/17/24.
//

import Foundation

struct MangaCoverResponse: Codable {
    let result: String?
    let response: String?
    let data: MangaCover?
}

struct MangaCover: Codable, Identifiable {
    let id: String
    let type: String?
    let attributes: MangaCoverAttributes?
    let relationships: [MangaCoverRelationship]?
}

struct MangaCoverAttributes: Codable {
    let description: String?
    let volume: String?
    let fileName: String?
    let locale: String?
    let createdAt: String?
    let updatedAt: String?
    let version: Int?
}

struct MangaCoverRelationship: Codable, Identifiable {
    let id: String?
    let type: String?
}
