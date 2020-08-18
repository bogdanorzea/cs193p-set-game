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
                ShowHintButton(viewModel: viewModel)
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

            DealMoreCardsButton {
                withAnimation {
                    self.viewModel.dealMore()
                }
            }
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

struct ShowHintButton: View {
    @ObservedObject var viewModel: SetGameViewModel
    @State var isAlertVisible: Bool = false

    var body: some View {
        Button(action: {
            withAnimation {
                self.isAlertVisible = !self.viewModel.showHint()
            }
        }, label: {
            Text("Hint")
        })
            .padding()
            .alert(isPresented: $isAlertVisible) {
                Alert(
                    title: Text("No sets available"),
                    message: Text("Do you want to deal more cards"),
                    primaryButton: .default(Text("Yes")) {
                        withAnimation { self.viewModel.dealMore() }
                    },
                    secondaryButton: .cancel()
                )
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
