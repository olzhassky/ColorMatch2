import SwiftUI

struct NavigationViewItems: View {
    @Binding var isNameInputViewPresented: Bool
    @Binding var playerNameInput: String
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        HStack {
            NavigationLink(destination: InfoView()) {
                Image(systemName: "gear")
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
                NameInputView(isPresented: $isNameInputViewPresented,
                              playerNameInput: $playerNameInput)
                    .onDisappear {
                        let currentRecord = GameRecord(playerName: playerNameInput,
                                                       score: 0)
                        modelContext.insert(currentRecord)
                    }
            }
        }
    }
}
