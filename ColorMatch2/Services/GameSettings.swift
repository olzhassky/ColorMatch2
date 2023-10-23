//
//  GameSettings.swift
//  ColorMatch2
//
//  Created by Ярослав on 23.10.2023.
//

import SwiftUI

class GameSettings: ObservableObject {
    @Published var columns: Int = 3
    @Published var rows: Int = 3
}
