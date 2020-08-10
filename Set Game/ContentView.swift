//
//  ContentView.swift
//  Set Game
//
//  Created by Bogdan Orzea on 8/5/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let game = SetGame()

        return VStack {
            ForEach(game.cards.prefix(10)) { card in
                CardView(card: card)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
