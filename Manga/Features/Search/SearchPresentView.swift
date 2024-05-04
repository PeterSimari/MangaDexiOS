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
                authorStack
                descriptionStack
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
                .background(.mangaDarkGray)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        )
        .tint(.primary) // This prevents NavigationStack from rendering all the text as blue
    }
    
    var coverThumbnail: some View {
        CoverArtAsyncImage(url: mangaVM.generateCoverURL(manga: manga),
                      maxWidth: 150,
                      maxHeight: 200)
            .padding(.trailing, 10)
    }
    
    var titleStack: some View {
        HStack {
            Text(originalLanguage.getFlag())
                .font(.title)
            
            Text("\(manga.attributes?.title?.en ?? "")")
                .font(.title)
                .multilineTextAlignment(.leading)
            Text("\(originalLanguage.getAltTitles(manga: manga))")
                .font(.title2)
            Spacer()
        }
    }
    
    var authorStack: some View {
        HStack {
            Text("\(mangaVM.getArtistName(manga: manga))")
            Spacer()
        }
    }
    
    var descriptionStack: some View {
        HStack {
            Text("\(mangaVM.getSplitDescription(manga: manga))")
                .font(.caption)
                .multilineTextAlignment(.leading)
                .frame(alignment: .leading)
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
