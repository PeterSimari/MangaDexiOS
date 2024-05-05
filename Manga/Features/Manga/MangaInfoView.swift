//
//  MangaInfoView.swift
//  Manga
//
//  Created by Peter Simari on 2/25/24.
//

import Foundation
import SwiftUI

struct MangaInfoView: View {
    @StateObject private var mangaVM = MangaViewModel()
    var manga: Manga
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundImage
                frontContent
            }
            .navigationTitle(mangaVM.getShortTitle(manga))
        }
    }
    
    var frontContent: some View {
        ScrollView {
            VStack {
                HStack {
                    frontImage
                    titleStack
                    Spacer()
                }
            }
        }
    }
    
    var frontImage: some View {
        VStack {
            CoverArtAsyncImage(url: mangaVM.generateCoverURL(manga: manga),
                               maxWidth: 250)
            .padding(.leading, 25)
            .padding(.trailing, 10)
            .padding(.top, 20)
            Spacer()
            TagStack(tags: mangaVM.getTags(manga))
        }
    }
    
    var titleStack: some View {
        VStack {
            HStack {
                Text("\(mangaVM.getTitle(manga))")
                    .font(.largeTitle)
                    .multilineTextAlignment(.leading)
                    .frame(alignment: .leading)
                Spacer()
            }
            HStack {
                Text("\(OriginalLanguage(rawValue: mangaVM.getOriginalLanguage(manga) )?.getFlag() ?? "")")
                    .font(.largeTitle)
                Text("\(mangaVM.getArtistName(manga))")
                    .font(.title)
                Spacer()
            }
            HStack {
                Text("\(mangaVM.getDescriptionPreDash(manga))")
                    .multilineTextAlignment(.leading)
                    .frame(alignment: .leading)
                Spacer()
            }
            Spacer()
        }
        .padding(.top, 20)
    }
    
    var backgroundImage: some View {
        VStack {
            CoverArtAsyncImage(url: mangaVM.generateCoverURL(manga: manga),
                          imageScaler: .scaledToFill,
                          contentMode: .fill,
                          height: 450,
                          alignment: .top,
                          opacity: 0.5,
                          blurRadius: 10)
            Spacer()
        }
    }
}
