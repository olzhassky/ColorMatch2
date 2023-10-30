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
    @State var selectedGridSize = GameSettings.shared.selectedGridOption
    var gridOptions = ["3×3", "4×4", "5×5"]
    
    var timerOptions = ["5", "10", "15"]
    @State var timerPick = GameTimer.sharedTimer.selectedTimerOption
    
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
                    ForEach(gridOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer()
                    .frame(height: 25)
                
                Picker("Timer", selection: $timerPick ) {
                    ForEach(timerOptions, id: \.self) { timer in
                        Text(timer)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                Spacer()
            }
                .navigationBarTitle("Information")
                .padding([.leading, .trailing], 25)
                .onAppear {
                    selectedGridSize = GameSettings.shared.selectedGridOption
                    timerPick = GameTimer.sharedTimer.selectedTimerOption
                }
                .onChange(of: selectedGridSize) {
                    GameSettings.shared.columns = Int(String(selectedGridSize.first ?? "3")) ?? 3
                }
        )
        
    }
}
