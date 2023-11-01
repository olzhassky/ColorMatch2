//
//  NameInputView.swift
//  ColorMatch2
//
//  Created by Akerke on 22.10.2023.
//

import Foundation
import SwiftUI

struct NameInputView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented: Bool
    @Binding var playerNameInput: String
    @FocusState var isFocused: NameField?
    
    enum NameField {
        case playerName
    }
    
    var body: some View {
        VStack {
            TextField("Your Name", text: $playerNameInput)
                .focused($isFocused, equals: .playerName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("OK") {
                isPresented = false
                modelContext.insert(GameRecord(playerName: playerNameInput, score: 0))
            }
            .padding()
            .presentationDetents([.height(125)])
    
        }
        .onAppear{
            isFocused = .playerName
        }
    }
}
