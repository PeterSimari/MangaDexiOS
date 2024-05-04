//
//  ViewExtensions.swift
//  Manga
//
//  Created by Peter Simari on 5/4/24.
//

import Foundation
import SwiftUI

public enum ImageScaled {
    case none, scaledToFit, scaledToFill
}

extension View {
    @ViewBuilder
    @inlinable public func determineScaled(_ scaler: ImageScaled) -> some View {
        switch scaler {
        case .none:
            self.border(.black, width: 0)
        case .scaledToFit:
            self.scaledToFit()
        case .scaledToFill:
            self.scaledToFill()
        }
    }
}
