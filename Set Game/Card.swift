//
//  Card.swift
//  Set Game
//
//  Created by Bogdan Orzea on 8/9/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//
import Foundation

struct Card: Identifiable {
    let id = UUID()
    let shape: CardShape
    let number: Int
    let color: CardColor
    let shading: CardShading
}

enum CardShape: CaseIterable {
    case diamond
    case oval
    case squiggle
}

enum CardShading: CaseIterable {
    case solid
    case striped
    case outlined
}

enum CardColor: CaseIterable {
    case red
    case purple
    case green
}
