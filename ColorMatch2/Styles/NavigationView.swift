import SwiftUI

@available(iOS 17.0, *)
struct NavigationViewItems: View {
    @Binding var isNameInputViewPresented: Bool
    @Binding var playerNameInput: String
    @ObservedObject var gameRecords: GameLogic

    var body: some View {
        HStack {
            NavigationLink(destination: InfoView()) {
                Image(systemName: "info.circle")
                    .font(.title)
            }

            Spacer()

            Button {
                isNameInputViewPresented = true
            } label: {
                Image(systemName: "play.circle")
                    .font(.title)
            }
            .sheet(isPresented: $isNameInputViewPresented) {
                NameInputView(isPresented: $isNameInputViewPresented, playerNameInput: $playerNameInput)
                    .onDisappear {
                        let record = GameRecord(playerName: playerNameInput, score: gameRecords.score)
                        gameRecords.gameRecords.append(record)
                        gameRecords.startGame()

                        let currentRecord = GameRecord(playerName: playerNameInput, score: gameRecords.score)
                        
                        }
                    }
            }
        }
    }

