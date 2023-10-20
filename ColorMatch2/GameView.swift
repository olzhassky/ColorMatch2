//
//  ContentView.swift
//  ColorMatch2
//
//  Created by Olzhas Zhakan on 30.09.2023.
//

import SwiftUI
import Combine


struct NameInputView: View {
    
    @Binding var isPresented: Bool
    @Binding var playerNameInput: String
    
    var body: some View {
        VStack {
            TextField("Your Name", text: $playerNameInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("OK") {
                isPresented = false
                UserDefaults.standard.set(playerNameInput, forKey: "playerName")
                
            }
            .padding()
        }
    }
}

struct GameView: View {
    @State private var gameRecords: [GameRecord] = []
    
    @ObservedObject var gameLogic = GameLogic()
    @State var isTapped = false
    

    
    @State private var playerNameInput: String = ""
    @State private var isNameInputViewPresented: Bool = false
    
    @State private var isInfoViewPresented = false
    //    переменные для анимации
    @State private var ellipseOneWidth: CGFloat = 200
    @State private var ellipseOneHeight: CGFloat = 200
    
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
                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                    center: .center,
                    startRadius: 0,
                    endRadius: 500
                )
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack {
                        Text(" \(gameLogic.timeRemaining) sec.")
                            .font(.system(size: 46))
                            .bold()
                            .frame(width: ellipseOneWidth, height: ellipseOneHeight,
                                   alignment: .center)
                            .animation(Animation
                                .easeInOut(duration: 1.5))
                        
                        Text("Score: \(gameLogic.score)")
                            .font(.system(size: 26))
                        
                        
                        LazyVGrid(columns: columns) {
                            ForEach(0 ..< gameLogic.colors.count, id: \.self) { index in
                                Button(action: {
                                    gameLogic.playerTapped(index: index)
//                                    if firstSelectedColor == nil {
//                                        firstSelectedColor = gameLogic.colors[index]
//                                    } else if secondSelectedColor == nil {
//                                        secondSelectedColor = gameLogic.colors[index]
//                                        if firstSelectedColor == secondSelectedColor {
//                                            gameLogic.score += 1
//                                            if gameLogic.score >= gameLogic.currentRound {
//                                                gameLogic.startNextRound()
//                                            }
//                                        } else {
//                                            gameLogic.showGameOverAlert = true
//                                        }
//                                        firstSelectedColor = nil
//                                        secondSelectedColor = nil
//                                    }
                                }, label: {
                                    
                                    Spacer()
                                })
                                .buttonStyle(ColorButtonStyle(backgroundColor: gameLogic.colors[index]))
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
                        .navigationBarTitle("ColorMatch", displayMode: .inline)
                    
                        .navigationBarItems(
                            leading:
                                HStack {
                                    NavigationLink(destination: InfoView()) {
                                        Image(systemName: "info.circle")
                                            .font(.title)
                                    }
                                },
                            
                            trailing:
                                HStack {
                                    Button {
                                        isNameInputViewPresented = true
                                    } label: {
                                        Image(systemName: "play.fill")
                                            .font(.title)
                                    }
                                    .sheet(isPresented: $isNameInputViewPresented) {
                                        NameInputView(isPresented: $isNameInputViewPresented, playerNameInput: $playerNameInput)
                                            .onDisappear {
                                                let record = GameRecord(playerName: playerNameInput, score: gameLogic.score)
                                                gameRecords.append(record)
                                                gameLogic.startGame()
                                                
                                                let currentRecord = GameRecord(playerName: playerNameInput, score: gameLogic.score)
                                                if let data = try? JSONEncoder().encode(currentRecord) {
                                                    UserDefaults.standard.set(data, forKey: "currentRecord")
                                                }
                                            }
                                    }
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
                    gradient: Gradient(colors: [Color.blue, Color.purple]),
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
                        
                        List {
                            ForEach(gameRecords) { record in
                                HStack {
                                    Text(record.playerName)
                                    Spacer()
                                    Text("\(record.score) очков")
                                }
                            }
                            .onDelete(perform: swipeOnDelete)
                        }
                        .listStyle(PlainListStyle())
                        .background(Color.clear)
                        
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
        .onAppear {
            gameLogic.generateColors()
            if let data = UserDefaults.standard.data(forKey: "gameRecords") {
                do {
                    gameRecords = try JSONDecoder().decode([GameRecord].self, from: data)
                } catch {
                    print("Error decoding game records: \(error)")
                }
            }
        }
    }
}

struct InfoView: View {
    var body: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color.blue, Color.purple]),
            center: .center,
            startRadius: 0,
            endRadius: 500
        )
        .edgesIgnoringSafeArea(.all)
        .overlay(
            VStack {
                Text("Инструкция")
            }
                .navigationBarTitle("Information")
        )
    }
}

private extension GameView {
    
    func swipeOnDelete(at offsets: IndexSet) {
        gameRecords.remove(atOffsets: offsets)
        let gameLogic = GameLogic()
        gameLogic.saveGameRecords()
    }
}

//#Preview {
//    GameView()
//}


