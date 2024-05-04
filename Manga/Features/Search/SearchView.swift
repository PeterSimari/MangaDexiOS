//
//  SearchView.swift
//  Manga
//
//  Created by Peter Simari on 2/18/24.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @StateObject private var searchVM = SearchViewModel()
    @State private var basicSearch: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search by Title", text: $basicSearch)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit { searchVM.searchManga(withTitle: basicSearch) }
                Spacer()
                ScrollView(showsIndicators: false) {
                    Spacer().frame(height: 5)
                    ForEach(searchVM.mangas?.data ?? []) { manga in
                        NavigationLink(destination: MangaInfoView(manga: manga)) {
                            SearchPresentView(manga: manga)
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .padding(20)
        }
    }
}

#Preview {
    SearchView()
}
