//
//  Services.swift
//  ColorMatch2
//
//  Created by Ярослав on 07.10.2023.
//

import SwiftUI
import Combine

class GameLogic: ObservableObject {
    // для таблицы с рекордами
    @Published var gameRecords: [GameRecord] = []
    @Published var selectedIndices: [Int] = []
    
    @Published var colors: [Color] = []
    @Published var score = 0
    
    @Published var showGameOverAlert = false
    

    @Published var timeRemaining = 15
    var timer: Timer?
    
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
        let timeOption = GameSettings.shared.timer
        timeRemaining = timeOption
        generateColors()
        startTimer()
    }
    
    func startNextRound() {
        stopTimer()
        score += 1
        let timeOption = GameSettings.shared.timer
        timeRemaining = timeOption
        generateColors()
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
}
