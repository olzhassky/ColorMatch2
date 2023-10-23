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
    var body: some View {
        RadialGradient(
            gradient: Gradient(colors: [Color.blue, Color.purple]),
            center: .center,
            startRadius: 0,
            endRadius: 500
        )
        .edgesIgnoringSafeArea(.all)
        .overlay(
            VStack {
                Text("Инструкция")
            }
                .navigationBarTitle("Information")
        )
    }
}
