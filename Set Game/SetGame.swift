//
//  Game.swift
//  Set Game
//
//  Created by Bogdan Orzea on 8/9/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import Foundation

struct SetGame {
    private(set) var cards: [Card]

    init() {
        cards = [Card]()

        for shape in CardShape.allCases {
            for color in CardColor.allCases {
                for number in 1...3 {
                    for shading in CardShading.allCases {
                        let card = Card(shape: shape, number: number, color: color, shading: shading)

                        self.cards.append(card)
                    }
                }
            }
        }

        cards.shuffle()
    }
}
