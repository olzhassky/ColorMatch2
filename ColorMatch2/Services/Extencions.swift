//
//  Extencions.swift
//  ColorMatch2
//
//  Created by Akerke on 23.10.2023.
//

import SwiftUI

@available(iOS 17.0, *)
extension ScoreView {
    func swipeOnDelete(at offsets: IndexSet) {
        gameRecords.remove(atOffsets: offsets)
        gameLogic.saveGameRecords()
    }
}


