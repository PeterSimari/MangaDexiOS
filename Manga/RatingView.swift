//
//  RatingView.swift
//  Manga
//
//  Created by Peter Simari on 2/19/24.
//

import Foundation
import SwiftUI

struct RatingView: View {
    var rating: String
    var ratingEnum: Rating
    
    init(rating: String) {
        self.rating = rating
        self.ratingEnum = Rating(rawValue: rating) ?? .nonNil
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: ratingEnum.getRatingIcon())
                Text(ratingEnum.getRatingName())
                    .font(Font.headline)
            }
            .padding(.horizontal, 7)
            .padding(.vertical, 4)
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .inset(by: 1)
                .stroke(ratingEnum.getRatingColor(), lineWidth: 1)
                .background(ratingEnum.getRatingColor().opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        )
    }
}

enum Rating: String {
    case nonNil
    case erotica = "erotica"
    case suggestive = "suggestive"
    case safe = "safe"
    
    func getRatingColor() -> Color {
        switch self {
        case .nonNil:
            return .black
        case .erotica:
            return .red
        case .suggestive:
            return .yellow
        case .safe:
            return .green
        }
    }
    
    func getRatingName() -> String {
        switch self {
        case .nonNil:
            return "error reading rating"
        case .erotica:
            return "Erotica"
        case .suggestive:
            return "Suggestive"
        case .safe:
            return "Safe"
        }
    }
    
    func getRatingIcon() -> String {
        switch self {
        case .nonNil:
            return ""
        case .erotica:
            return "figure.equestrian.sports"
        case .suggestive:
            return "figure.cooldown"
        case .safe:
            return "figure.fishing"
        }
    }
}

