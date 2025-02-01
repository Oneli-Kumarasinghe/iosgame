import SwiftUI

struct GameView: View {
    @State private var game = GameModel.generateNewGame()
    @State private var selectedColors = [Color]()
    
    var body: some View {
        VStack {
            Text("Time: \(game.timeRemaining)")
                .font(.title)
                .padding()
            
            Text("Score: \(game.score)")
                .font(.title2)
            
            // 3x3 Grid
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(0..<9) { index in
                    let color = game.colors[index]
                    Button(action: {
                        if game.selectedColors.contains(color) {
                            game.score += 10
                            if game.score > game.highestScore {
                                game.highestScore = game.score
                                UserDefaults.standard.set(game.highestScore, forKey: "highestScore")
                            }
                        } else {
                            game.score -= 5
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color)
                            .frame(width: 80, height: 80)
                    }
                }
            }
            
            Spacer()
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            game.timer?.invalidate() // Stop the timer when the view disappears
        }
    }
    
    func startTimer() {
        game.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if game.timeRemaining > 0 {
                game.timeRemaining -= 1
            } else {
                game.timer?.invalidate()
                // End game
            }
        }
    }
}
