//
//  MangaSearchPresentView.swift
//  Manga
//
//  Created by Peter Simari on 2/18/24.
//

import Foundation
import SwiftUI

struct MangaSearchPresentView: View {
    @StateObject private var mangaVM = MangaViewModel()
//    var manga: Manga
    
//    init(mangaVM: MangaViewModel = MangaViewModel(), manga: Manga = manga) {
//        self.manga = manga
//        self.tags = getTags() // write this in ViewModel or something. definitely not here
//    }
    
    var body: some View {
        //        HStack {
        //            AsyncImage(
        //                url: URL(string: mangaVM.fetchMangaCover(manga)),
        //                content: { image in
        //                    image.resizable()
        //                        .aspectRatio(contentMode: .fit)
        //                        .frame(maxWidth: 200, maxHeight: 200)
        //                },
        //                placeholder: {
        //                    ProgressView()
        //                }
        //            )
        //            VStack {
        //                Text("\(manga.attributes?.title?.en ?? "")")
        //                Text("\(getAltTitles(manga: manga))")
        //                Text("\(manga.attributes?.description?.en ?? "")")
        //            }
        //        }
        HStack {
            coverThumbnail
            VStack {
                titleStack
                Text(
"""
Guts, known as the Black Swordsman, seeks sanctuary from the demonic forces attracted to him and his woman because of a demonic mark on their necks, and also vengeance against the man who branded him as an unholy sacrifice. Aided only by his titanic strength gained from a harsh childhood lived with mercenaries, a gigantic sword, and an iron prosthetic left hand, Guts must struggle against his bleak destiny, all the while fighting with a rage that might strip him of his humanity.
"""
                )
                .font(.caption)
                infoStack
                tagStack
            }
            Spacer()
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 3)
                .stroke(.black, lineWidth: 5)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        )
    }
    
    var coverThumbnail: some View {
        Image("berserk")
            .resizable()
            .frame(maxWidth: 200, maxHeight: 300)
            .padding(.trailing, 10)
    }
    
    var titleStack: some View {
        HStack {
            Text("Berserk")
                .font(.title)
            Text("ベルセルク")
                .font(.title2)
            Text("(Beruseruku)")
                .font(.title3)
            Spacer()
        }
    }
    
    var infoStack: some View {
        HStack {
            Text("seinen")
            Text("ongoing")
            Text("erotica")
            Spacer()
        }
    }
    
    private var tags: [String] = ["Award Winning", "Monsters", "Action", "Demons", "Psychological", "Adventure", "Sexual Violence", "Philosophical", "Gore", "Drama", "Horror", "Fantasy", "Supernatural", "Tragedy"]
    
    var tagStack: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags, id: \.self) { tag in
                    TagView(tag: tag)
                }
            }
        }
    }
    
    func getAltTitles(manga: Manga) -> String {
        let originalLanguage = OriginalLanguage(rawValue: manga.attributes?.originalLanguage ?? "")
        for languages in manga.attributes?.altTitle ?? [] {
            switch originalLanguage {
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
}

