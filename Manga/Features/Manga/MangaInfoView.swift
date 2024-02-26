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
            ScrollView {
                ZStack {
                    backgroundImage
                    frontContent
                }
            }
            .onAppear() {
                
            }
            .navigationTitle(mangaVM.manga?.data?.attributes?.title?.en ?? "")
        }
    }
    
    var backgroundImage: some View {
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
    }
    
    var frontContent: some View {
        VStack {
            Text("\(manga.id)")
            Text("\(manga.attributes?.title?.en ?? "")")
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
    }
}
