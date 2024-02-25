//
//  SearchView.swift
//  Manga
//
//  Created by Peter Simari on 2/18/24.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @StateObject private var mangaVM = MangaViewModel()
    @State private var basicSearch: String = ""
    
    var body: some View {
        VStack {
            TextField("Search for Manga", text: $basicSearch)
                .textFieldStyle(.roundedBorder)
                .onSubmit { mangaVM.searchManga(title: basicSearch) }
            Spacer()
            ScrollView(showsIndicators: false) {
                Spacer().frame(height: 5)
//                ForEach(1...10, id: \.self) {_ in
//                    MangaSearchPresentView()
//                }
                ForEach(mangaVM.mangas?.data ?? []) { manga in
                    MangaSearchPresentView(manga: manga)
                }
            }
        }
        .padding(20)
        .background(.gray)
    }
}

#Preview {
    SearchView()
}
