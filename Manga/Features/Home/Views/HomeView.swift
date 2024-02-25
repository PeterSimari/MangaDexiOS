//
//  HomeView.swift
//  Manga
//
//  Created by Peter Simari on 1/2/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @StateObject private var mangaVM = MangaViewModel()
    @StateObject private var searchMangaVM = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    PopularNewTitles()
                    Seasonal()
                    StaffPicks()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(searchMangaVM.mangas?.data ?? []) { manga in
                                MangaPresentView(manga: manga)
                            }
                            .padding(.trailing, 10)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                HStack {
                    NavigationLink(destination: SearchView()) {
                        Text("Search")
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .onAppear() {
                //            mangaVM.fetchStaffPicks()
            }
        }
    }
    
}

struct PopularNewTitles: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Popular New Titles")
                .frame(alignment: .leading)
            TabView {
                Text("First Manga").tabItem {}
                Text("Second Manga").tabItem {}
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .frame(maxHeight: 200)
            .frame(height: 200, alignment: .center)
        }
        .padding(.vertical, 20)
    }
    
    private func makeNewTitlesView() -> any View {
        var body: some View {
            Text("hi")
        }
        return body
    }
}

struct Seasonal: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Seasonal Manga")
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    Text("Hi")
                    Text("Hi")
                }
                // ForEach whatever we pull in thats Seasonal
            }
        }
    }
}

struct StaffPicks: View {
    @StateObject private var mangaVM = MangaViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            Text("Staff Picks")
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(mangaVM.manyMangas?.data ?? []) { manga in
                        MangaPresentView(manga: manga)
                    }
                    .padding(.trailing, 10)
                }
                // ForEach whatever we pull in thats Staff Picks
            }
        }
    }
}

//#Preview {
//    HomeView()
//}
