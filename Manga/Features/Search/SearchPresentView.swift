//
//  SearchPresentView.swift
//  Manga
//
//  Created by Peter Simari on 2/18/24.
//

import Foundation
import SwiftUI

struct SearchPresentView: View {
    @StateObject private var mangaVM = MangaViewModel()
    var manga: Manga
    var originalLanguage: OriginalLanguage
    var tags: [String]
    
    init(mangaVM: MangaViewModel = MangaViewModel(), manga: Manga) {
        self.manga = manga
        self.tags = mangaVM.getTags(manga: manga)
        self.originalLanguage = OriginalLanguage(rawValue: manga.attributes?.originalLanguage ?? "") ?? .none
    }
    
    var body: some View {
        HStack {
            coverThumbnail
            VStack {
                titleStack
                Text("\(mangaVM.getSplitDescription(manga: manga))")
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .frame(alignment: .leading)
                infoStack
                tagStack
                Spacer()
            }
            Spacer()
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 1)
                .stroke(.black, lineWidth: 2)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        )
        .tint(.primary) // This prevents NavigationStack from rendering all the text as blue
    }
    
    var coverThumbnail: some View {
        AsyncImage(
            url: URL(string: mangaVM.generateCoverURL(manga: manga)),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 150, maxHeight: 200)
                    .padding(.trailing, 10)
            },
            placeholder: {
                ProgressView()
            }
        )
    }
    
    var titleStack: some View {
        HStack {
            Text(originalLanguage.getFlag())
                .font(.title)
            
            Text("\(manga.attributes?.title?.en ?? "")")
                .font(.title)
            Text("\(originalLanguage.getAltTitles(manga: manga))")
                .font(.title2)
//            Text("Berserk")
//                .font(.title)
//            Text("ベルセルク")
//                .font(.title2)
            Spacer()
        }
    }
    
    var infoStack: some View {
        HStack {
            StatusView(status: manga.attributes?.status ?? "")
            DemographicView(demographic: manga.attributes?.publicationDemographic ?? "")
            RatingView(rating: manga.attributes?.contentRating ?? "")
            Spacer()
        }
    }
    
    var tagStack: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags, id: \.self) { tag in
                    TagView(tag: tag)
                }
            }
        }
    }
}

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

