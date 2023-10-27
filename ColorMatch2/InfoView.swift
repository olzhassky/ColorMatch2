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
                
                //                Button("Okay") {
                //                    GameSettings.shared.columns = Int(String(selectedGridSize.first ?? "3")) ?? 3
                //                    print(GameSettings.shared.columns)
                //                }
                //                .foregroundColor(.pink)
                //                .buttonStyle(.borderedProminent)
                
                Spacer()
                
            }
                .navigationBarTitle("Information")
                .padding([.leading, .trailing], 25)
                .onAppear {
                    selectedGridSize = GameSettings.shared.selectedGridOption
                }
                .onChange(of: selectedGridSize) {
                    GameSettings.shared.columns = Int(String(selectedGridSize.first ?? "3")) ?? 3
                }
        )
    }
}
