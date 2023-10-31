//
//  InfoView.swift
//  ColorMatch2
//
//  Created by Akerke on 22.10.2023.
//

import Foundation
import SwiftUI


struct InfoView: View {
    
    @State var selectedGridSize = GameSettings.shared.selectedGridOption
    var gridOptions = ["3×3", "4×4", "5×5"]
    
    var timerOptions = ["5", "10", "15"]
    @State var timerPick = String(GameTimer.sharedTimer.timer)
    
    var body: some View {
        ScreenStyleGradient.radialGradient{
            VStack {
                Text ("Выберите размер ячеек:")
                    .font(.custom("Icdbold", size: 20))
                Picker("Grid Size", selection: $selectedGridSize) {
                    ForEach(gridOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                Text("Смысл игры найти два одинаковых цвета за определенное количество времени. Вы можете выбрать количество ячеек и количество времени для одного раунда.")
                    .font(.custom("Icdbold", size: 20))
                
                Spacer()
                    .frame(height: 25)
                Text("Выберите время прохождения раунда:")
                    .font(.custom("Icdbold", size: 20))
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
                timerPick = String(GameTimer.sharedTimer.timer)
            }
            .onChange(of: selectedGridSize) {
                GameSettings.shared.columns = Int(String(selectedGridSize.first ?? "3")) ?? 3
            }
            .onChange(of: timerPick) {
                print(timerPick)
                GameTimer.sharedTimer.timer = Int(timerPick) ?? 15
            }
            
            
        }
    }
}
