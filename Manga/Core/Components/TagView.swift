//
//  TagView.swift
//  Manga
//
//  Created by Peter Simari on 2/19/24.
//

import Foundation
import SwiftUI

struct TagView: View {
    var tag: String
    var tagColor: TagColor
    
    init(tag: String) {
        self.tag = tag
        self.tagColor = TagColor(rawValue: tag) ?? .nonNil
    }
    
    var body: some View {
        VStack {
            Text(tag)
                .font(Font.footnote)
                .padding(.horizontal, 7)
                .padding(.vertical, 4)
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .inset(by: 1)
                .stroke(tagColor.getTagColor(), lineWidth: 1)
                .background(tagColor.getTagColor().opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        )
    }
}

enum TagColor: String {
    case nonNil
    case awardWinning = "Award Winning"
    case monsters = "Monsters"
    case action = "Action"
    case demons = "Demons"
    case psychological = "Psychological"
    case adventure = "Adventure"
    case sexViolence = "Sexual Violence"
    case philosophical = "Philosophical"
    case gore = "Gore"
    case drama = "Drama"
    case horror = "Horror"
    case fantasy = "Fantasy"
    case supernatural = "Supernatural"
    case tragedy = "Tragedy"
    
    func getTagColor() -> Color {
        switch self {
        case .nonNil:
            return .black
        case .awardWinning:
            return .yellow
        case .monsters, .demons, .sexViolence, .gore:
            return .red
        case .action, .supernatural, .tragedy:
            return .orange
        case .psychological, .philosophical, .drama, .horror:
            return .purple
        case .adventure, .fantasy:
            return .green
        }
    }
}
