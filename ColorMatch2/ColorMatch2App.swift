//
//  ColorMatch2App.swift
//  ColorMatch2
//
//  Created by Olzhas Zhakan on 30.09.2023.
//

import SwiftUI
import SwiftData

@main
struct ColorMatch2App: App {
    @StateObject private var variables = Variables()
    
    var body: some Scene {
        WindowGroup {
            GameView()
                .preferredColorScheme(.light)
                .accentColor(.white)
                .environmentObject(variables)
        }
    }
}
