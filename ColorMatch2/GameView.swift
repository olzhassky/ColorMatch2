//
//  ContentView.swift
//  ColorMatch2
//
//  Created by Olzhas Zhakan on 30.09.2023.
//

import SwiftUI

struct GameView: View {
    @State private var showRestartAlert = false
    @State private var showGameOverAlert = false
    
    @ObservedObject var gameLogic = GameLogic()
    @State var timeRemaining = 15
    
    @State var isTapped = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
                
                Text("Time remaining: \(timeRemaining) sec.")
                    .font(.callout)
                    .bold()
                
                Spacer()
                
                LazyVGrid(columns: columns) {
                    ForEach(0 ..< gameLogic.colors.count, id: \.self) { index in
                        Button(action: {
                            
                        }, label: {
                            Spacer()
                        })
                        .buttonStyle(ColorButtonStyle(backgroundColor: gameLogic.colors[index]))
                    }
                }
                .alert(isPresented: $showRestartAlert) {
                    Alert(title: Text("Вы уверены?"), message: Text("Начать игру заново"), primaryButton: .destructive(Text("Да")) {
                    }, secondaryButton: .cancel())
                }
                .alert(isPresented: $showGameOverAlert) {
                    Alert(title: Text("Вы проиграли"),
                          message: Text("Игра начнется заново!"),
                          dismissButton: .destructive(Text("Окей")) {
                        timeRemaining = 30
                        gameLogic.generateColors()
                    })
                }
                
                Spacer()
                
                Button("Random") {
                    gameLogic.generateColors()
                }
                .buttonStyle(.bordered)
                
                Spacer()
            }
            .navigationBarTitle("ColorMatch", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    self.showRestartAlert = true
                }) {
                    Image(systemName: "arrow.2.squarepath")
                }
            )
        }
        .onAppear {
            gameLogic.generateColors()
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                presentGameOver()
            }
        }
    }
    
    func presentGameOver() {
        showGameOverAlert = true
    }
}

#Preview {
    GameView()
}
