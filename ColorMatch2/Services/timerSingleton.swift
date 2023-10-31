//
//  timerSingleton.swift
//  ColorMatch2
//
//  Created by Olzhas Zhakan on 28.10.2023.
//

import Foundation

class GameTimer: ObservableObject {
    static let sharedTimer = GameTimer()
    @Published var timer: Int
    
    private init() {
        self.timer = 10
    }
}


