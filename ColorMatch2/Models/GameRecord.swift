//
//  GameRecord.swift
//  ColorMatch2
//
//  Created by Ярослав on 01.11.2023.
//

import SwiftUI
import SwiftData

@Model
class GameRecord: Identifiable {
    @Attribute(.unique) let id = UUID()
    var playerName: String
    var score: Int
    
    init(playerName: String, score: Int) {
        self.playerName = playerName
        self.score = score
    }
}
