//
//  Cardify.swift
//  Set Game
//
//  Created by Bogdan Orzea on 8/10/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isSelected: Bool
    let isMatched: Bool

    func body(content: Content) -> some View {
        let cardColor = isSelected
            ? isMatched ? matchedBackgroundColor : selectedBackGroundColor
            : backgroundColor

        return ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(cardColor).opacity(backgroundOpacity)
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(cardColor, lineWidth: lineWidth)
            content
        }.animation(.easeOut)
    }

    // MARK: - Drawing constants
    let cornerRadius = CGFloat(5)
    let lineWidth = CGFloat(2)
    let backgroundColor = Color.gray
    let selectedBackGroundColor = Color.blue
    let matchedBackgroundColor = Color.green
    let backgroundOpacity = 0.1
}

extension View {
    func cardify(isSelected: Bool, isMatched: Bool) -> some View {
        self.modifier(Cardify(isSelected: isSelected, isMatched: isMatched))
    }
}
