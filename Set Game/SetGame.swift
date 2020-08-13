//
//  Game.swift
//  Set Game
//
//  Created by Bogdan Orzea on 8/9/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import Foundation

struct SetGame {
    static private let defaultNumberOfCardsToShow = 12

    private(set) var cards: [Card]
    private(set) var numberOfCardsToShow = defaultNumberOfCardsToShow
    private var selectedIndices: [Int]

    init() {
        selectedIndices = [Int]()
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

    mutating func chose(card: Card) {
        if let index = cards.firstIndex(where: { $0 == card }), !cards[index].isMatched {
            if selectedIndices.count > 2 {
                deselectAllCards()
                reduceNumberOfVisibleCards()
            }

            cards[index].isSelected = !cards[index].isSelected
            if cards[index].isSelected {
                selectedIndices.append(index)

                if areSelectedCardsASet {
                    markSelectedCardsAsUsed()
                }
            } else {
                if let indexToRemove = selectedIndices.firstIndex(of: index) {
                    selectedIndices.remove(at: indexToRemove)
                }
            }
        } else {
            deselectAllCards()
        }
    }

    mutating func dealMore() {
        if areSelectedCardsASet {
            markSelectedCardsAsUsed()
            reduceNumberOfVisibleCards()
        } else {
            self.numberOfCardsToShow += 3
        }
        deselectAllCards()
    }

    mutating private func reduceNumberOfVisibleCards() {
        if self.numberOfCardsToShow > SetGame.defaultNumberOfCardsToShow {
            self.numberOfCardsToShow -= 3
        }
    }

    private var areSelectedCardsASet: Bool {
        if self.selectedIndices.count != 3 {
            return false
        } else {
            let first = cards[selectedIndices[0]]
            let second = cards[selectedIndices[1]]
            let third = cards[selectedIndices[2]]

            let shapes: Set<CardShape> = [first.shape, second.shape, third.shape]
            let numbers: Set<Int> = [first.number, second.number, third.number]
            let colors: Set<CardColor> = [first.color, second.color, third.color]
            let shadings: Set<CardShading> = [first.shading, second.shading, third.shading]

            return shapes.count != 2 && numbers.count != 2 && colors.count != 2 && shadings.count != 2
        }
    }

    mutating private func markSelectedCardsAsUsed() {
        if self.selectedIndices.count != 3 {
            return
        }

        cards[selectedIndices[0]].isMatched = true
        cards[selectedIndices[1]].isMatched = true
        cards[selectedIndices[2]].isMatched = true
    }

    mutating private func deselectAllCards() {
        for i in selectedIndices {
            cards[i].isSelected = false
        }

        selectedIndices.removeAll()
    }
}
