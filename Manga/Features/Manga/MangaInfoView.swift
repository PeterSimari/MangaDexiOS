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
        AsyncImage(
            url: URL(string: mangaVM.generateCoverURL(manga: manga)),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300, maxHeight: 450)
                    .padding(.leading, 35)
                    .padding(.top, 20)
            },
            placeholder: {
                ProgressView()
            }
        )
    }
    
    var titleStack: some View {
        VStack {
            Text("\(manga.attributes?.title?.en ?? "")")
                .font(.largeTitle)
            Text("\(OriginalLanguage(rawValue: manga.attributes?.originalLanguage ?? "")?.getFlag() ?? "")")
                
            Spacer()
        }
        .padding(.top, 20)
    }
    
    var backgroundImage: some View {
        VStack {
            AsyncImage(
                url: URL(string: mangaVM.generateCoverURL(manga: manga)),
                content: { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(height: 350, alignment: .top)
                        .opacity(0.5)
                        .clipped()
                        .blur(radius: 3)
                },
                placeholder: {
                    ProgressView()
                }
            )
            Spacer()
        }
    }
}
