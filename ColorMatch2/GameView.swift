//
//  ContentView.swift
//  ColorMatch2
//
//  Created by Olzhas Zhakan on 30.09.2023.
//

import SwiftUI
import Combine

struct GameView: View {
    @EnvironmentObject var variables: Variables
    
    @State var gameRecords: [GameRecord] = []
    @ObservedObject var gameLogic = GameLogic()
    
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
                ScreenStyleGradient.radialGradient{
                    VStack {
                        //    переопределение свой метод для анимации
                        Text(" \(gameLogic.timeRemaining) sec.")
                            .monospacedDigit()
                            .transition(.scale.combined(with: .slide))
                            .font(.custom("Montserrat-Bold", size: 46))
                            .bold()
                            .frame(width: variables.ellipseOneWidth, height: variables.ellipseOneHeight, alignment: .center)
                            .animation(.easeInOut(duration: 0.5), value: gameLogic.timeRemaining)
                        
                        Text("Score: \(gameLogic.score)")
                            .font(.system(size: 26))
                        
                        
                        LazyVGrid(columns: columns) {
                            ForEach(0 ..< gameLogic.colors.count, id: \.self) { index in
                                Button(action: {
                                    gameLogic.playerTapped(index: index)
                                }, label: {
                                    Spacer()
                                })
                                .buttonStyle(ColorButtonStyle(backgroundColor: gameLogic.colors[index]))
                                .overlay {
                                    if gameLogic.selectedIndices.contains(index) {
                                        Image(systemName: "checkmark.circle")
                                            .foregroundColor(.white)
                                            .font(.system(size: 48))
                                    }
                                }
                            }
                        }
                        .alert(isPresented: $gameLogic.showGameOverAlert) {
                            Alert(title: Text("Вы проиграли"),
                                  message: Text("Игра начнется заново!"),
                                  dismissButton: .destructive(Text("Окей")) {
                                gameLogic.startGame()
                            })
                        }
                        
                        Spacer()
                    }
                    //       поменять текст тайтла
                    .navigationBarTitle("ColorMatch", displayMode: .inline)
                    
                    .navigationBarItems(
                        trailing: NavigationViewItems(isNameInputViewPresented: $variables.isNameInputViewPresented,
                                                      playerNameInput: $variables.playerNameInput,
                                                      gameRecords: gameLogic)
                    )
                }
            }
            
            .tabItem {
                Image(systemName: "gamecontroller")
                Text("Game")
            }
            
            ScoreView(gameRecords: $gameRecords, gameLogic: gameLogic)
                .tabItem {
                    Image(systemName: "flag.2.crossed.fill")
                    Text("Score")
                }
            
                .foregroundColor(.black)
        }
        .onAppear {
            gameLogic.generateColors()
            
        }
    }
}

//#Preview {
//    GameView()
//}


