//
//  ContentView.swift
//  ColorMatch2
//
//  Created by Olzhas Zhakan on 30.09.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var newColors: [Color] = []
    let columns: [GridItem] = [
        GridItem(.fixed(70), spacing: nil, alignment: nil),
        GridItem(.fixed(70), spacing: nil, alignment: nil),
        GridItem(.fixed(70), spacing: nil, alignment: nil),
        GridItem(.fixed(70), spacing: nil, alignment: nil)
    ]
    var body: some View {
        NavigationView {
            LazyVGrid(columns: columns) {
                ForEach(0..<newColors.count, id: \.self) { index in
                    Rectangle()
                        .frame(height: 70)
                        .foregroundColor(newColors[index])
                
                }
            }
            .navigationBarTitle("Random Color", displayMode: .large)
        }
        Button("Random") {
            generateColors()
        }
        .buttonStyle(.bordered)
        .cornerRadius(13)
        .padding(50)

    }
    func generateColors() {
        var colors: [Color] = []
        for i in 0..<14 {
            let randomColor = Color (
                            red: Double.random(in: 0...1),
                            green: Double.random(in: 0...1),
                            blue: Double.random(in: 0...1)
            )
            colors.append(randomColor)
        }
        let duplicatedColor = Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
        colors.append(duplicatedColor)
        colors.append(duplicatedColor)
        print(duplicatedColor)
        colors.shuffle()
        newColors = colors
        }
    
}


#Preview {
    ContentView()
}


