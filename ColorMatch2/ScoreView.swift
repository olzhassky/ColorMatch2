//
//  ScoreView.swift
//  ColorMatch2
//
//  Created by Akerke on 23.10.2023.
//

import SwiftUI
import SwiftData

struct ScoreView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var gameRecords: [GameRecord]

    var body: some View {
        NavigationView {
            ScreenStyleGradient.radialGradient{
                VStack {
                    List {
                        ForEach(gameRecords) { record in
                            HStack {
                                Text(record.playerName)
                                Spacer()
                                Text("\(record.score) очков")
                            }
                        }
                        .onDelete { indexSet in
                            let recordToRemove = gameRecords[indexSet.first!]
                            modelContext.delete(recordToRemove)
                        }
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


    

