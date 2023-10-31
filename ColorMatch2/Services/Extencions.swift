//
//  Extencions.swift
//  ColorMatch2
//
//  Created by Akerke on 23.10.2023.
//

import SwiftUI

extension ScoreView {
        func swipeOnDelete(at offsets: IndexSet) {
            gameRecords.remove(atOffsets: offsets)
            gameLogic.saveGameRecords()
        }
    }
    
//    for family in UIFont.familyNames {
//        print("Family: \(family)")
//        for name in UIFont.fontNames(forFamilyName: family) {
//            print("Name: \(name)")
//        }
//    }

