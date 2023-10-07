//
//  ContentView.swift
//  ColorMatch2
//
//  Created by Olzhas Zhakan on 30.09.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    @State private var showGameOverAlert = false
    
    @State private var newColors: [Color] = []
    @State var timeRemaining = 15
    
    @State var isTapped = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let columns: [GridItem] = [
        GridItem(.fixed(70), spacing: nil, alignment: nil),
        GridItem(.fixed(70), spacing: nil, alignment: nil),
        GridItem(.fixed(70), spacing: nil, alignment: nil),
        GridItem(.fixed(70), spacing: nil, alignment: nil)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("Time remaining: \(timeRemaining) sec.")
                    .font(.callout)
                    .bold()
                
                Spacer()
                
                LazyVGrid(columns: columns) {
                    ForEach(0 ..< newColors.count, id: \.self) { index in
                        Button(action: {
                            
                        }, label: {
                            Spacer()
                        })
                        .buttonStyle(ColorButtonStyle(backgroundColor: newColors[index]))
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Вы уверены?"), message: Text("Начать игру заново"), primaryButton: .destructive(Text("Да")) {
                    }, secondaryButton: .cancel())
                }
                .alert(isPresented: $showGameOverAlert) {
                    Alert(title: Text("Вы проиграли"),
                          message: Text("Игра начнется заново!"),
                          dismissButton: .destructive(Text("Окей")) {
                        timeRemaining = 30
                        generateColors()
                    })
                }
                
                Spacer()
                
                Button("Random") {
                    generateColors()
                }
                .buttonStyle(.bordered)
                
                Spacer()
            }
            .navigationBarTitle("ColorMatch", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    self.showAlert.toggle()
                }) {
                    Text("Рестарт")
                }
            )
        }
        .onAppear {
            generateColors()
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                presentGameOver()
            }
        }
    }
    
    func presentGameOver() {
        showGameOverAlert = true
    }
    
    func generateColors() {
        var colors: [Color] = []
        for _ in 0 ..< 14 {
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
