//
//  StatusView.swift
//  Manga
//
//  Created by Peter Simari on 2/19/24.
//

import Foundation
import SwiftUI

struct StatusView: View {
    var status: String
    var statusEnum: Status
    
    init(status: String) {
        self.status = status
        self.statusEnum = Status(rawValue: status) ?? .nonNil
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: statusEnum.getStatusIcon())
                Text(statusEnum.getStatusName())
                    .font(Font.headline)
            }
            .padding(.horizontal, 7)
            .padding(.vertical, 4)
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .inset(by: 1)
                .stroke(statusEnum.getStatusColor(), lineWidth: 1)
                .background(statusEnum.getStatusColor().opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        )
    }
}

enum Status: String {
    case nonNil
    case ongoing = "ongoing"
    case completed = "completed"
    case hiatus = "hiatus"
    case cancelled = "cancelled"
    
    func getStatusColor() -> Color {
        switch self {
        case .nonNil:
            return .black
        case .ongoing:
            return .green
        case .completed:
            return .purple
        case .hiatus:
            return .yellow
        case .cancelled:
            return .red
        }
    }
    
    func getStatusName() -> String {
        switch self {
        case .nonNil:
            return "error reading status"
        case .ongoing:
            return "Ongoing"
        case .completed:
            return "Completed"
        case .hiatus:
            return "Hiatus"
        case .cancelled:
            return "Cancelled"
        }
    }
    
    func getStatusIcon() -> String {
        switch self {
        case .nonNil:
            return ""
        case .ongoing:
            return "arrowshape.right.circle.fill"
        case .completed:
            return "checkmark.circle"
        case .hiatus:
            return "hand.raised"
        case .cancelled:
            return "xmark.circle"
        }
    }
}

