//
//  GameSettings.swift
//  ColorMatch2
//
//  Created by Ярослав on 23.10.2023.
//

import SwiftUI

class GameSettings: ObservableObject {
    static let shared = GameSettings()
    @Published  var columns: Int
    @Published var rows: Int

   private init() {
        self.columns = 5
       self.rows = 5
       
    }
}


