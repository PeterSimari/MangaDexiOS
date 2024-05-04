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
            .navigationTitle(manga.attributes?.title?.en ?? "")
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
        CoverArtAsyncImage(url: mangaVM.generateCoverURL(manga: manga),
                      maxWidth: 300,
                      maxHeight: 800)
            .padding(.leading, 35)
            .padding(.top, 20)
    }
    
    var titleStack: some View {
        VStack {
            Text("\(OriginalLanguage(rawValue: manga.attributes?.originalLanguage ?? "")?.getFlag() ?? "")")
                .font(.largeTitle)
            Text("\(manga.attributes?.title?.en ?? "")")
                .font(.largeTitle)
            
            Spacer()
        }
        .padding(.top, 20)
    }
    
    var backgroundImage: some View {
        VStack {
            CoverArtAsyncImage(url: mangaVM.generateCoverURL(manga: manga),
                          imageScaler: .scaledToFill,
                          contentMode: .fill,
                          height: 350,
                          alignment: .top,
                          opacity: 0.5,
                          blurRadius: 10)
//            AsyncImage(
//                url: URL(string: mangaVM.generateCoverURL(manga: manga)),
//                content: { image in
//                    image
//                        .resizable()
//                        .scaledToFill()
//                        .frame(height: 350, alignment: .top)
//                        .opacity(0.5)
//                        .clipped()
//                        .blur(radius: 10)
//                },
//                placeholder: {
//                    ProgressView()
//                }
//            )
            Spacer()
        }
    }
}
