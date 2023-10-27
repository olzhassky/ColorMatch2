//
//  ScoreView.swift
//  ColorMatch2
//
//  Created by Akerke on 23.10.2023.
//

import SwiftUI
import SwiftData


@available(iOS 17.0, *)
struct ScoreView: View {
    
    @Environment(\.modelContext) private var modelContext
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
                    
                    List(gameRecords) { record in
                        HStack {
                            Text(record.playerName)
                            Spacer()
                            Text("\(record.score) очков")
                        }
                    }
                    //                        .onDelete(perform: swipeOnDelete)
                }
                .listStyle(PlainListStyle())
                .background(Color.clear)
                
                Spacer()
            }
            .navigationBarTitle("Score", displayMode: .inline)
        }
    }
    }



