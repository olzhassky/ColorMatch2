//
//  Services.swift
//  ColorMatch2
//
//  Created by Ярослав on 07.10.2023.
//

import SwiftUI

class GameLogic: ObservableObject {
    @Published var colors: [Color] = []
    
    init() {
        generateColors()
    }
    
    func generateColors() {
        var colors: [Color] = []
        for _ in 0 ..< 14 {
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
}
