//
//  DemographicView.swift
//  Manga
//
//  Created by Peter Simari on 2/19/24.
//

import Foundation
import SwiftUI

struct DemographicView: View {
    var demographic: String
    var demographicEnum: Demographic
    
    init(demographic: String) {
        self.demographic = demographic
        self.demographicEnum = Demographic(rawValue: demographic) ?? .nonNil
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: demographicEnum.getDemographicIcon())
                Text(demographicEnum.getDemographicName())
                    .font(Font.headline)
            }
            .padding(.horizontal, 7)
            .padding(.vertical, 4)
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .inset(by: 1)
                .stroke(demographicEnum.getDemographicColor(), lineWidth: 1)
                .background(demographicEnum.getDemographicColor().opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        )
    }
}

enum Demographic: String {
    case nonNil
    case seinen = "seinen"
    case shounen = "shounen"
    case shoujo = "shoujo"
    case josei = "josei"
    
    func getDemographicColor() -> Color {
        switch self {
        case .nonNil:
            return .black
        case .seinen:
            return .red
        case .shounen:
            return .blue
        case .shoujo:
            return .green
        case .josei:
            return .pink
        }
    }
    
    func getDemographicName() -> String {
        switch self {
        case .nonNil:
            return "error reading demographic"
        case .seinen:
            return "Seinen"
        case .shounen:
            return "Shounen"
        case .shoujo:
            return "Shoujo"
        case .josei:
            return "Josei"
        }
    }
    
    func getDemographicIcon() -> String {
        switch self {
        case .nonNil:
            return ""
        case .seinen:
            return "figure.walk.motion"
        case .shounen:
            return "figure.walk"
        case .shoujo:
            return "figure.fall"
        case .josei:
            return "figure.wave"
        }
    }
}

