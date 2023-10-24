//
//  InfoView.swift
//  ColorMatch2
//
//  Created by Akerke on 22.10.2023.
//

import Foundation
import SwiftUI
//настройки игры будут
struct InfoView: View {
@StateObject var gameLogic = GameLogic()
    var gridSizeOptions = [
        (columns: 3, rows: 3),
        (columns: 4, rows: 4),
        (columns: 5, rows: 5)
    ]
    @State  var selectedGridSize = 1
 
    var body: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color.red, Color.purple]),
            center: .center,
            startRadius: 0,
            endRadius: 500
        )
        .edgesIgnoringSafeArea(.all)
        .overlay(
            VStack {
                Picker("Grid Size", selection: $selectedGridSize) {
                    ForEach(0..<gridSizeOptions.count, id: \.self) { index in
                        Text("\(gridSizeOptions[index].columns) x \(gridSizeOptions[index].rows)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
    
                   
                Button("Okay") {
                    let selectedSize = gridSizeOptions[selectedGridSize]
                                    GameSettings.shared.columns = selectedSize.columns
                                    GameSettings.shared.rows = selectedSize.rows
                                    gameLogic.generateColors()
                }
                Spacer()

            }
                .navigationBarTitle("Information")
        )
    }
}
