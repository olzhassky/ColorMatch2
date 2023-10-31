//
//  ScreenStyle.swift
//  ColorMatch2
//
//  Created by Akerke on 23.10.2023.
//

import SwiftUI

struct ScreenStyleGradient {
    static func radialGradient<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        RadialGradient(
            gradient: Gradient(colors: [Color.color1, Color.color1]),
            center: .center,
            startRadius: 0,
            endRadius: 500
        )
        .edgesIgnoringSafeArea(.all)
        .overlay(content())
    }
}

