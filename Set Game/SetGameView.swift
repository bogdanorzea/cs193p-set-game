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
            HStack {
                DealMoreCardsButton {
                    withAnimation {
                        self.viewModel.dealMore()
                    }
                }
                Spacer()
                NewGameButton {
                    withAnimation {
                        self.viewModel.newGame()
                    }
                }
            }

            Grid(viewModel.cardsToShow) { card in
                CardView(card: card)
                    .padding(5)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            self.viewModel.chose(card: card)
                        }
                    }
                    .transition(.move(edge: Edge.allCases.randomElement()!))
            }
                .padding()
        }
        .onAppear {
            self.viewModel.newGame()
        }
    }
}

struct DealMoreCardsButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action, label: {
            Text("Deal 3 more cards")
        })
            .padding()
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
