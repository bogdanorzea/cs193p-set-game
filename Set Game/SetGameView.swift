//
//  ContentView.swift
//  Set Game
//
//  Created by Bogdan Orzea on 8/5/20.
//  Copyright © 2020 Bogdan Orzea. All rights reserved.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel

    var body: some View {
        VStack {
            Grid(Array(viewModel.cards.prefix(12))) { card in
                CardView(card: card).padding(5)
            }

            NewGameButton {
                self.viewModel.resetGame()
            }
        }
    }
}

struct NewGameButton: View {
    @State var isDialogPresented: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: {
            self.isDialogPresented = true
        }, label: {
            Text("New game")
        })
            .padding()
            .alert(isPresented: $isDialogPresented) {
                Alert(
                    title: Text("Start new game"),
                    primaryButton: .default(Text("Yes"), action: action ),
                    secondaryButton: .cancel()
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView(viewModel: SetGameViewModel())
    }
}
