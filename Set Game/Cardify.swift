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

    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(isSelected ? selectedBackGroundColor : backgroundColor).opacity(backgroundOpacity)
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(isSelected ? selectedBackGroundColor : backgroundColor, lineWidth: lineWidth)
            content
        }.animation(.easeOut)
    }

    // MARK: - Drawing constants
    let cornerRadius = CGFloat(5)
    let lineWidth = CGFloat(2)
    let backgroundColor = Color.gray
    let selectedBackGroundColor = Color.blue
    let backgroundOpacity = 0.1
}

extension View {
    func cardify(isSelected: Bool) -> some View {
        self.modifier(Cardify(isSelected: isSelected))
    }
}
