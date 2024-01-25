//
//  MangaPresentView.swift
//  Manga
//
//  Created by Peter Simari on 1/16/24.
//

import Foundation
import SwiftUI

struct MangaPresentView: View {
    @StateObject private var mangaVM = MangaViewModel()
    var manga: Manga
    
    var body: some View {
        AsyncImage(
            url: URL(string: mangaVM.fetchMangaCover(manga)),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300, maxHeight: 500)
            },
            placeholder: {
                ProgressView()
            }
        )
    }
}
