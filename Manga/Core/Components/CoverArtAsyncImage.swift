//
//  CoverArtAsyncImage.swift
//  Manga
//
//  Created by Peter Simari on 5/3/24.
//

import Foundation
import SwiftUI

struct CoverArtAsyncImage: View {
    var url: String
    var imageScaler: ImageScaled = .none
    var contentMode: ContentMode = .fit
    var width: CGFloat?
    var height: CGFloat?
    var alignment: Alignment = .top
    var maxWidth: CGFloat?
    var maxHeight: CGFloat?
    var opacity: Double = 1.0
    var blurRadius: CGFloat = 0
    
    var transitionDuration: Double = 0.7
    
    var body: some View {
        AsyncImage(url: URL(string: url),
                   transaction: .init(animation: .easeIn(duration: transitionDuration))) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .determineScaled(imageScaler)
                    .aspectRatio(contentMode: contentMode)
                    .frame(width: width, height: height, alignment: alignment)
                    .frame(maxWidth: maxWidth, maxHeight: maxHeight)
                    .opacity(opacity)
                    .clipped()
                    .blur(radius: blurRadius)
                    
            case .empty:
                ZStack {
                    Rectangle()
                        .frame(alignment: alignment)
                        .frame(width: width, height: height, alignment: alignment)
                        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
                        .foregroundColor(.gray)
                        .opacity(0.3)
                        .clipped()
                    ProgressView()
                }
            case .failure:
                ZStack {
                    Rectangle()
                        .frame(alignment: alignment)
                        .frame(width: width, height: height, alignment: alignment)
                        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
                        .foregroundColor(.gray)
                        .opacity(0.3)
                        .clipped()
                    Text("failure, sorry! lmao")
                }
            @unknown default:
                ZStack {
                    Rectangle()
                        .frame(alignment: alignment)
                        .frame(width: width, height: height, alignment: alignment)
                        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
                        .foregroundColor(.gray)
                        .opacity(0.3)
                        .clipped()
                    Text("unknown error :thonk:")
                }
            }
        }
    }
}
