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
    
    
    @State private var playerName: String = ""

    let columns: [GridItem] = [
        GridItem(.fixed(70), spacing: nil, alignment: nil),
        GridItem(.fixed(70), spacing: nil, alignment: nil),
        GridItem(.fixed(70), spacing: nil, alignment: nil),
        GridItem(.fixed(70), spacing: nil, alignment: nil)
    ]
    
    var body: some View {
        
        TabView {
            // Вкладка 1
            NavigationView {
                RadialGradient(
                            gradient: Gradient(colors: [Color.red, Color.purple]),
                            center: .center,
                            startRadius: 0,
                            endRadius: 500
                        )
                        .edgesIgnoringSafeArea(.all)
                        .overlay(
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
                )
            }
            .tabItem {
                Image(systemName: "gamecontroller")
                Text("Game")
            }

            // Вкладка 2
            NavigationView {
                RadialGradient(
                            gradient: Gradient(colors: [Color.red, Color.purple]),
                            center: .center,
                            startRadius: 0,
                            endRadius: 500
                        )
                        .edgesIgnoringSafeArea(.all)
                        .overlay(
                VStack {
                    Spacer()

                    Text("Табличка с рекордами")
                        .font(.callout)
                        .bold()
                    
                    List(gameLogic.gameRecords) { record in
                        HStack {
                            Text(record.playerName)
                            Spacer()
                            Text("\(record.score) очков")
                        }
                    }
             
                       
                    
                    
                    Spacer()
                    TextField("Напиши свое имя", text: $playerName)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Добавить") {
                        gameLogic.addRecord(playerName: playerName, score: gameLogic.score)
                    }
                    .buttonStyle(.bordered)
                    
                    Spacer()
                }
                .navigationBarTitle("Score", displayMode: .inline)
                )
            }
            .tabItem {
                Image(systemName: "flag.2.crossed.fill")
                Text("Score")
                
            }
            .foregroundColor(.black)
        }
        .foregroundColor(.black)
        .onAppear {
            gameLogic.generateColors()
        }
    }
    }



#Preview {
    GameView()
}
