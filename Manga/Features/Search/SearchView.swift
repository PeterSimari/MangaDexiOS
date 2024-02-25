//
//  SearchView.swift
//  Manga
//
//  Created by Peter Simari on 2/18/24.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @StateObject private var mangaVM = SearchViewModel()
    @State private var basicSearch: String = ""
    
    var body: some View {
        VStack {
            TextField("Search for Manga", text: $basicSearch)
                .textFieldStyle(.roundedBorder)
                .onSubmit { mangaVM.searchManga(withTitle: basicSearch) }
            Spacer()
            ScrollView(showsIndicators: false) {
                Spacer().frame(height: 5)
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
