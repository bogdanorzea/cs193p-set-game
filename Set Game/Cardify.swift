//
//  Cardify.swift
//  Set Game
//
//  Created by Bogdan Orzea on 8/10/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(backgroundColor).opacity(backgroundOpacity)
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(backgroundColor, lineWidth: lineWidth)
            content
        }
    }

    // MARK: - Drawing constants
    let cornerRadius = CGFloat(5)
    let lineWidth = CGFloat(2)
    let backgroundColor = Color.gray
    let backgroundOpacity = 0.1
}

extension View {
    func cardify() -> some View {
        self.modifier(Cardify())
    }
}
