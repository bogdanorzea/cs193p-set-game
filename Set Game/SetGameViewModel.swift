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

    init() {
        self.model = SetGame()
    }

    // MARK: - Access to the Model
    var cards: [Card] {
        return model.cards
    }

    var cardsToShow: [Card] {
        Array(self.cards.filter { !$0.isHidden }.prefix(self.model.numberOfCardsToShow))
    }

    // MARK: - Intent(s)
    func resetGame() {
        model = SetGame()
    }

    func chose(card: Card) {
        model.chose(card: card)
    }

    func dealMore() {
        model.dealMore()
    }
}
