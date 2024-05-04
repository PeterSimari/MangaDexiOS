//
//  ContentView.swift
//  Manga
//
//  Created by Peter Simari on 1/2/24.
//

import SwiftUI

struct ContentView: View {
    @State public var path = NavigationPath()
    
    var body: some View {
        VStack {
            TabView {
                NavigationStack {
                    HomeView()
                }
                .tabItem {
                    Label("Home", systemImage: "globe")
                }
                
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.orange)
                    Text("Manga Dex Library")
                }
                .tabItem {
                    Label("Library", systemImage: "globe")
                }
                
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.orange)
                    Text("Manga Dex Account")
                }
                .tabItem {
                    Label("Account", systemImage: "globe")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
