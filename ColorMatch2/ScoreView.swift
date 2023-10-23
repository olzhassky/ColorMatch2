//
//  ScoreView.swift
//  ColorMatch2
//
//  Created by Akerke on 23.10.2023.
//

import SwiftUI

struct ScoreView: View {
    @Binding var gameRecords: [GameRecord]
    @ObservedObject var gameLogic: GameLogic
    
    var body: some View {
        NavigationView {
            ScreenStyleGradient.radialGradient{
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
            }
        }
        .foregroundColor(.black)
    }

}

