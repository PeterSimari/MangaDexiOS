//
//  MangaInfoView.swift
//  Manga
//
//  Created by Peter Simari on 2/25/24.
//

import Foundation
import SwiftUI

struct MangaInfoView: View {
    var mangaID: String
    
    var body: some View {
        VStack {
            Text("\(mangaID)")
        }
    }
}
