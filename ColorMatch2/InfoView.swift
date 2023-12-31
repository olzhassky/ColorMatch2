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
    
    var timerOptions = ["5", "15", "20"]
    @State var timerPick = String(GameSettings.shared.timer)
    
    @State private var selectedColor: Color = .lightBlue
    let colorOptions: [Color] = [.lightBlue, .lightPink, .lightPurple]

    
    var body: some View {
        ScreenStyleGradient.radialGradient{
            VStack {
                                ViewStyleForSmallText.styledView{
                    Text ("Выберите размер ячеек:")
                        .font(.custom("PlaypenSans", size: 20))
                }.frame(width: 400, height: 50)
                
                
                Picker("Grid Size", selection: $selectedGridSize) {
                    ForEach(gridOptions, id: \.self) { option in
                        Text(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                HStack {
                            Image("3x3")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 130, height: 130)
                            
                            Image("4x4")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 130, height: 130)
                            
                            Image("5x5")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 130, height: 130)
                        }
                
                ViewStyleForSmallText.styledView{
                    Text("Смысл игры найти два одинаковых цвета за определенное количество времени. Вы можете выбрать количество ячеек и количество времени для одного раунда.")
                        .font(.custom("PlaypenSans", size: 20))
                        .padding()
                    
                }.frame(width: 400, height: 200)
                
                Spacer()
                    .frame(height: 25)
                ViewStyleForSmallText.styledView{
                    Text("Выберите время прохождения раунда:")
                    .font(.custom("PlaypenSans", size: 20))}
                .frame(width: 400, height: 50)
                
                Picker("Timer", selection: $timerPick ) {
                    ForEach(timerOptions, id: \.self) { timer in
                        Text(timer)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                Spacer()
            }
            .navigationBarTitle("Settings")
            .padding([.leading, .trailing], 25)
            .onAppear {
                selectedGridSize = GameSettings.shared.selectedGridOption
                timerPick = String(GameSettings.shared.timer)
            }
            .onChange(of: selectedGridSize) {
                GameSettings.shared.columns = Int(String(selectedGridSize.first ?? "3")) ?? 3
            }
            .onChange(of: timerPick) {
                GameSettings.shared.timer = Int(timerPick) ?? 15
            }
         
         
        }
    }
}
