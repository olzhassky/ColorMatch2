//
//  ButtonStyles.swift
//  ColorMatch2
//
//  Created by Ярослав on 07.10.2023.
//

import SwiftUI
import SwiftData

struct ColorButtonStyle: ButtonStyle {
    var backgroundColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .frame(width: 70, height: 70)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
