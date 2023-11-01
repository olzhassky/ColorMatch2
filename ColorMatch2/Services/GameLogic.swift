//
//  Services.swift
//  ColorMatch2
//
//  Created by Ярослав on 07.10.2023.
//

import SwiftUI
import Combine

// для таблицы с рекордами

class GameRecord: Identifiable, Codable {
    var id = UUID()
    var playerName: String
    var score: Int
    
    init(id: UUID = UUID(), playerName: String, score: Int) {
        self.id = id
        self.playerName = playerName
        self.score = score
    }
}


class GameLogic: ObservableObject {
    
    // для таблицы с рекордами
    @Published var gameRecords: [GameRecord] = []
    
    @Published var selectedIndices: [Int] = []
    
    @Published var colors: [Color] = []
    @Published var score = 0
    
    @Published var showGameOverAlert = false
    

    @Published var timeRemaining = 30
    var timer: Timer?
    var currentTime = 30
    
    init() {
        generateColors()
    }
    
    func generateColors() {
        var colors: [Color] = []
        for _ in 0 ..< (GameSettings.shared.columns * GameSettings.shared.columns) - 2 {
            let randomColor = Color (
                red: Double.random(in: 0...1),
                green: Double.random(in: 0...1),
                blue: Double.random(in: 0...1)
            )
            colors.append(randomColor)
        }
        let duplicatedColor = Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
        colors.append(duplicatedColor)
        colors.append(duplicatedColor)
        
        self.colors = colors.shuffled()
    }
    
    func startGame() {
        score = 0
        selectedIndices = []
        let timeOption = GameTimer.sharedTimer.timer
        timeRemaining = timeOption
        generateColors()
        startTimer()
    }
    
    func startNextRound() {
        stopTimer()
        score += 1
        generateColors()
//        if currentTime > 10 {
//            currentTime -= 5
//        } else {
//            currentTime = 10
//        }
//        timeRemaining = currentTime
        startTimer()
    }
    
    func startTimer() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.presentGameOver()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func presentGameOver() {
        self.stopTimer()
        showGameOverAlert = true
    }
    
    func playerTapped(index: Int) {
        if selectedIndices.count > 0 {
            selectedIndices.append(index)
            
            guard selectedIndices[0] != selectedIndices[1] else {
                selectedIndices.removeAll()
                return
            }
            
            if colors[selectedIndices[0]] == colors[selectedIndices[1]] {
                startNextRound()
            } else {
                presentGameOver()
            }
            
            selectedIndices.removeAll()
            
        } else {
            selectedIndices.append(index)
        }
    }
    
    //    для таблицы с рекордами
    func addRecord(playerName: String, score: Int) {
        let record = GameRecord(playerName: playerName, score: score)
        gameRecords.append(record)
        saveGameRecords()
    }
    
    func remove(at offsets: IndexSet) {
         gameRecords.remove(atOffsets: offsets)
     }
    
    func saveGameRecords() {
        //            код для сохр рекордов
        func saveGameRecords() {
            do {
                let data = try JSONEncoder().encode(gameRecords)
                UserDefaults.standard.set(data, forKey: "gameRecords")
            } catch {
                print("Error encoding game records: \(error)")
            }
        }
    }
}
