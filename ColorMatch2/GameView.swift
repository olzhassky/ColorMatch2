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
    @StateObject var gameLogic = GameLogic()
    
    var body: some View {
        TabView {
            // Вкладка 1
            NavigationView {
                ScreenStyleGradient.radialGradient{
                    VStack(spacing: 100) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.black.opacity(0.5))
                                .frame(width: 200, height: 100)
                            
                            Text(" \(gameLogic.timeRemaining) sec.")
                                .monospacedDigit()
                                .transition(.scale.combined(with: .slide))
                                .font(.custom("Icdbold", size: 46))
                                .bold()
                                .foregroundColor(.white)
                                .frame(width: variables.ellipseOneWidth, height: variables.ellipseOneHeight, alignment: .center)
                                .animation(.easeInOut(duration: 0.5), value: gameLogic.timeRemaining)
                            
                            VStack {
                                Spacer()
                                Text("Score: \(gameLogic.score)")
                                    .font(.system(size: 26))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.5))
                                    .cornerRadius(30)
                                    .offset(y: 50)
                            }
                        }
                        
                        LazyVGrid(columns: GameSettings.shared.gridItems) {
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
            gameLogic.startGame()
        }
        .onChange(of: GameSettings.shared.columns) {
            gameLogic.startGame()
        }
    }
}

#Preview {
    GameView()
}


