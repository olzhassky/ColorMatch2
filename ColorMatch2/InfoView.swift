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
        ScreenStyleGradient.radialGradient{
            VStack {
                Text("Инструкция")
            }
            .navigationBarTitle("Information")  
        }
    }
}
