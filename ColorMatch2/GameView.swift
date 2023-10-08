//
//  ContentView.swift
//  ColorMatch2
//
//  Created by Olzhas Zhakan on 30.09.2023.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameLogic = GameLogic()
    @State var isTapped = false
    
    @State var firstSelectedColor: Color? = nil
    @State var secondSelectedColor: Color? = nil

    let columns: [GridItem] = [
        GridItem(.fixed(70), spacing: nil, alignment: nil),
        GridItem(.fixed(70), spacing: nil, alignment: nil),
        GridItem(.fixed(70), spacing: nil, alignment: nil),
        GridItem(.fixed(70), spacing: nil, alignment: nil)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("Time remaining: \(gameLogic.timeRemaining) sec.")
                    .font(.callout)
                    .bold()
                
                Spacer()
                
                Text("Score \(gameLogic.score)")
                
                Spacer()
                
                LazyVGrid(columns: columns) {
                    ForEach(0 ..< gameLogic.colors.count, id: \.self) { index in
                        Button(action: {
                            if firstSelectedColor == nil {
                                firstSelectedColor = gameLogic.colors[index]
                            } else if secondSelectedColor == nil {
                                secondSelectedColor = gameLogic.colors[index]
                                if firstSelectedColor == secondSelectedColor {
                                    gameLogic.score += 1
                                    if gameLogic.score >= gameLogic.currentRound {
                                        gameLogic.startNextRound()
                                    }
                                } else {
                                    gameLogic.showGameOverAlert = true
                                }
                                firstSelectedColor = nil
                                secondSelectedColor = nil
                            }
                        }, label: {
                            Spacer()
                        })
                        .buttonStyle(ColorButtonStyle(backgroundColor: gameLogic.colors[index]))
                    }
                }
                .alert(isPresented: $gameLogic.showRestartAlert) {
                    Alert(title: Text("Вы уверены?"), message: Text("Начать игру заново"), primaryButton: .destructive(Text("Да")) {
                    }, secondaryButton: .cancel())
                }
                .alert(isPresented: $gameLogic.showGameOverAlert) {
                    Alert(title: Text("Вы проиграли"),
                          message: Text("Игра начнется заново!"),
                          dismissButton: .destructive(Text("Окей")) {
                        gameLogic.startGame()
                    })
                }
                
                Spacer()
                
                Button("Start") {
                    gameLogic.startGame()
                    gameLogic.isGameStart = true
                }
                .buttonStyle(.bordered)
               // .opacity(gameLogic.isGameStart ? 0 : 1)
                
                Spacer()
            }
            .navigationBarTitle("ColorMatch", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    self.gameLogic.showRestartAlert = true
                }) {
                    Image(systemName: "arrow.2.squarepath")
                }
            )
        }
        .onAppear {
            gameLogic.generateColors()
        }
    }
}


#Preview {
    GameView()
}
