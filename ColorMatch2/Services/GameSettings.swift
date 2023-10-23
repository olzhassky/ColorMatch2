//
//  GameSettings.swift
//  ColorMatch2
//
//  Created by Akerke on 23.10.2023.
//

import SwiftUI

class GameSettings: ObservableObject {
    @Published var columnsCount = 4
    @Published var rowsCount = 4
    
    @Published  var columns: [GridItem] = Array.init(repeating: GridItem(.fixed(70)), count: columnsCount)
}
