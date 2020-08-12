//
//  SetGameViewModel.swift
//  Set Game
//
//  Created by Bogdan Orzea on 8/10/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import Foundation

class SetGameViewModel: ObservableObject {
    @Published var model: SetGame
    @Published var numberOfCardsToShow: Int = 12

    init() {
        self.model = SetGame()
    }

    // MARK: - Access to the Model
    var cards: [Card] {
        return model.cards
    }

    // MARK: - Intent(s)
    func resetGame() {
        model = SetGame()
        numberOfCardsToShow = 12
    }

    func choseCard(_ card: Card) {
        model.choseCard(card)
    }

    func showMoreCards() {
        numberOfCardsToShow += 3
    }
}
