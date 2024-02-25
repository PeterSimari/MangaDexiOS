//
//  Manga.swift
//  Manga
//
//  Created by Peter Simari on 1/6/24.
//

import Foundation

struct MangaResponse: Codable {
    let result: String?
    let response: String?
    let data: Manga?
    let limit: Int?
    let offset: Int?
    let total: Int?
}

struct MangasResponse: Codable {
    let result: String?
    let response: String?
    let data: [Manga]?
    let limit: Int?
    let offset: Int?
    let total: Int?
}

struct Manga: Identifiable, Codable {
    let id: String
    let type: String?
    let attributes: MangaAttributes?
    let relationships: [MangaRelationship]?
}

struct MangaRelationship: Identifiable, Codable {
    let id: String
    let type: String?
    let related: String?
    let attributes: MangaRelationshipAttributes?
}

struct MangaRelationshipAttributes: Codable {
    
}

struct MangaAttributes: Codable {
    let title: MangaTitle?
    let altTitle: [MangaTitle]?
    let description: MangaDescription?
    let isLocked: Bool?
    let links: MangaLinks?
    let originalLanguage: String?
    let lastVolume: String?
    let lastChapter: String?
    let publicationDemographic: String?
    let status: String?
    let year: Int?
    let contentRating: String?
    let chapterNumbersResetOnNewVolume: Bool?
    let latestUploadedChapter: String?
    let tags: [MangaTag]?
    let state: String?
    let version: Int?
    let createdAt: String?
    let updatedAt: String?
    
}

struct MangaTitle: Codable {
    let en: String?
    let ja: String?
    let ko: String?
}

struct MangaDescription: Codable {
    let en: String?
}

struct MangaLinks: Codable {
    let additionalProp1: String?
    let additionalProp2: String?
    let additionalProp3: String?
}

struct MangaTag: Identifiable, Codable {
    let id: String
    let type: String?
    let attributes: TagAttributes?
    let description: TagDescription?
    let group: String?
    let version: Int?
    let relationships: [TagRelationship]?
}

struct TagAttributes: Codable {
    let name: TagName?
}

struct TagName: Codable {
    let en: String?
}

struct TagDescription: Codable {
    let additionalProp1: String?
    let additionalProp2: String?
    let additionalProp3: String?
}

struct TagRelationship: Identifiable, Codable {
    let id: String
    let type: String?
    let related: String?
    let attributes: TagRelationshipAttributes?
}

struct TagRelationshipAttributes: Codable {
    
}
