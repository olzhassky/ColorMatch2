//
//  GameSettings.swift
//  ColorMatch2
//
//  Created by Ярослав on 23.10.2023.
//

import SwiftUI

class GameSettings: ObservableObject {
    static let shared = GameSettings()
    
    private let gridItem = GridItem(.fixed(70), spacing: nil, alignment: nil)
    var gridItems: [GridItem] = []
    var selectedGridOption: String { "\(columns)×\(columns)" }
    
    @Published var columns: Int {
        didSet {
            gridItems = Array.init(repeating: gridItem, count: columns)
        }
    }
    @Published var timer: Int

    var selectedTimerOption: String {
        String(timer)
       
    }
    
    private init() {
        self.timer = 15
        self.columns = 4
        gridItems = Array.init(repeating: gridItem, count: columns)
        
    }
}
