//
//  OriginalLanguage.swift
//  Manga
//
//  Created by Peter Simari on 4/12/24.
//

import Foundation

enum OriginalLanguage: String {
    case ja = "ja"
    case ko = "ko"
    case en = "en"
    case none = ""
    
    func fullName() -> String {
        switch self {
        case .ja:
            return "Japanese"
        case .ko:
            return "Korean"
        case .en:
            return "English"
        default:
            return "OriginalLanguage"
        }
    }
    
    func getFlag() -> String {
        switch self {
        case .ja:
            return "🇯🇵"
        case .ko:
            return "🇰🇷"
        case .en:
            return "🇺🇸"
        case .none:
            return ""
        }
    }
    
    func getAltTitles(manga: Manga) -> String {
        for languages in manga.attributes?.altTitle ?? [] {
            switch self {
            case .ja:
                return languages.ja ?? ""
            case .ko:
                return languages.ko ?? ""
            default:
                return ""
            }
        }
        return ""
    }
}

