//
//  ScoreView.swift
//  ColorMatch2
//
//  Created by Akerke on 23.10.2023.
//

import SwiftUI

struct ScoreView: View {
    
    @ObservedObject var gameLogic: GameLogic
    
    var body: some View {
        NavigationView {
            ScreenStyleGradient.radialGradient{
                VStack {
                    List {
                        ForEach(gameLogic.gameRecords) { record in
                            HStack {
                                Text(record.playerName)
                                Spacer()
                                Text("\(record.score) очков")
                            }
                        }
                        .onDelete(perform: gameLogic.remove)
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                    
                    Spacer()
                }
                .navigationBarTitle("Score", displayMode: .inline)
            }
        }
        .foregroundColor(.black)
    }
}


    

