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
    var contentMode: ContentMode = .fit
    var maxWidth: CGFloat = 150
    var maxHeight: CGFloat = 200
    var alignment: Alignment = .top
    var opacity: Double = 1.0
    var blurRadius: CGFloat = 0
    var transitionDuration: Double = 1
    
    var body: some View {
        AsyncImage(url: URL(string: url),
                   transaction: .init(animation: .easeIn(duration: transitionDuration))) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .frame(alignment: alignment)
                    .frame(maxWidth: maxWidth, maxHeight: maxHeight)
                    .opacity(opacity)
                    .blur(radius: blurRadius)
                    
            case .empty:
                ZStack {
                    Rectangle()
                        .frame(alignment: alignment)
                        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
                        .foregroundColor(.gray)
                        .opacity(0.6)
                    ProgressView()
                }
            case .failure:
                ZStack {
                    Rectangle()
                        .frame(alignment: alignment)
                        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
                        .foregroundColor(.gray)
                        .opacity(0.6)
                    Text("failure, sorry! lmao")
                }
            @unknown default:
                ZStack {
                    Rectangle()
                        .frame(alignment: alignment)
                        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
                        .foregroundColor(.gray)
                        .opacity(0.6)
                    Text("unknown error :thonk:")
                }
            }
        }
    }
}
