//
//  MangaColor.swift
//  Manga
//
//  Created by Peter Simari on 4/12/24.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    public static var mangaDarkGray: Color { Color(hex: 0x1f1f1f) }
}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
