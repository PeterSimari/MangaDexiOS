//
//  CoverArtImage.swift
//  Manga
//
//  Created by Peter Simari on 5/3/24.
//

import Foundation
import SwiftUI

struct CoverArtImage: View {
    var url: String
    var width: CGFloat = 150
    var height: CGFloat = 200
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Rectangle()
                        .frame(maxWidth: width, maxHeight: height)
                        .foregroundColor(.gray)
                    ProgressView()
                }
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: width, maxHeight: height)
            case .failure:
                ZStack {
                    Rectangle()
                        .frame(maxWidth: width, maxHeight: height)
                        .foregroundColor(.gray)
                    Text("failure, sorry! lmao")
                }
            @unknown default:
                ProgressView()
                Text("unknown")
            }
        }
    }
}
