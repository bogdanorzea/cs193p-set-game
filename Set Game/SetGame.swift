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
    var firstTwelveCards: [Card] {
        return Array(self.cards.filter { !$0.isMatched }.prefix(12))
    }

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

    mutating func choseCard(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0 == card }) {
            selectCardAt(index: chosenIndex)

            if selectedIndices.count > 2 {
                deselectAllCards()
            }
        }
    }

    mutating func selectCardAt(index: Int) {
        cards[index].isSelected = !cards[index].isSelected

        if cards[index].isSelected {
            selectedIndices.append(index)

            if selectedIndices.count == 3 {
                matchCards(
                    firstIndex: selectedIndices[0],
                    secondIndex: selectedIndices[1],
                    thirdIndex: selectedIndices[2]
                )
            }
        } else {
            if let indexToRemove = selectedIndices.firstIndex(of: index) {
                selectedIndices.remove(at: indexToRemove)
            }
        }
    }

    mutating func deselectAllCards() {
        selectedIndices.removeAll()

        for i in cards.indices {
            cards[i].isSelected = false
        }
    }

    mutating func matchCards(firstIndex: Int, secondIndex: Int, thirdIndex: Int) {
        let first = cards[firstIndex]
        let second = cards[secondIndex]
        let third = cards[thirdIndex]

        let shapes: Set<CardShape> = [first.shape, second.shape, third.shape]
        let numbers: Set<Int> = [first.number, second.number, third.number]
        let colors: Set<CardColor> = [first.color, second.color, third.color]
        let shadings: Set<CardShading> = [first.shading, second.shading, third.shading]

        if shapes.count != 2, numbers.count != 2, colors.count != 2, shadings.count != 2 {
            cards[firstIndex].isMatched = true
            cards[secondIndex].isMatched = true
            cards[thirdIndex].isMatched = true
        }
    }
}
