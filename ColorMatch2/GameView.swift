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
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        TabView {
            // Вкладка 1
            NavigationView {
                ScreenStyleGradient.radialGradient{
                    VStack(spacing: 100) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white.opacity(0.5))
                                .frame(width: 200, height: 100)
                            
                            Text(" \(gameLogic.timeRemaining) sec.")
                                .monospacedDigit()
                                .transition(.scale.combined(with: .slide))
                                .font(.custom("lcdbold", size: 46))
                                .bold()
                            
                                .frame(width: variables.ellipseOneWidth, height: variables.ellipseOneHeight, alignment: .center)
                                .animation(.easeInOut(duration: 0.5), value: gameLogic.timeRemaining)
                            
                            VStack {
                                Spacer()
                                Text("Score: \(gameLogic.score)")
                                    .font(.system(size: 26))
                                
                                    .padding()
                                    .background(Color.white.opacity(0.5))
                                    .cornerRadius(15)
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
                                modelContext.insert(GameRecord(playerName: "Guest", score: gameLogic.scoreEnd))
                                
                                gameLogic.startGame()
                                
                            })
                        }
                        
                        Spacer()
                        
                        
                            .navigationBarItems(
                                leading:NavigationLink(destination: InfoView()) {
                                    Image(systemName: "gear")
                                        .font(.title)
                                },
                                trailing: Button {
                                    gameLogic.startGame()
                                } label: {
                                    Image(systemName: "play.circle")
                                        .font(.title)
                                }
                            )
                        
                    }
                }
            }
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Game")
                }
                
                ScoreView()
                    .tabItem {
                        Image(systemName: "flag.2.crossed.fill")
                        Text("Score")
                    }
                
                    .foregroundColor(.black)
            }
            //        .onAppear {
            //            gameLogic.startGame()
            //        }
            .onChange(of: GameSettings.shared.columns) {
                gameLogic.startGame()
            }
        }
    }
    //
    //#Preview {
    //    GameView()
    //}
    
    
    
    

