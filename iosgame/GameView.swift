import SwiftUI

struct GameView: View {
    @State private var game: GameModel
    @State private var isGameOver = false
   
    let columns: [GridItem]

    init(difficulty: DifficultyLevel) {
        _game = State(initialValue: GameModel.generateNewGame(difficulty: difficulty))
       
        let gridSize = difficulty == .beginner ? 2 : 3
        columns = Array(repeating: GridItem(.flexible()), count: gridSize)
    }

    var body: some View {
        VStack {
            Text("Time: \(game.timeRemaining)")
                .font(.title)
                .padding()

            Text("Score: \(game.score)")
                .font(.title2)

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<game.colors.count, id: \.self) { index in
                    Button(action: {
                        if !game.handleColorSelection(index: index) {
                            endGame()
                        }
                    }) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(game.colors[index])
                            .frame(width: 80, height: 80)
                    }
                }
            }

            Spacer()

            if isGameOver {
                Text("Game Over!")
                    .font(.largeTitle)
                    .foregroundColor(.red)
                Button("Restart Game") {
                    restartGame()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            game.timer?.invalidate()
        }
    }

    func startTimer() {
        game.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if game.timeRemaining > 0 {
                game.timeRemaining -= 1
            } else if !isGameOver {
                endGame()
            }
        }
    }

    func endGame() {
        game.timer?.invalidate()
        isGameOver = true
    }

    func restartGame() {
        game.restartGame()
        startTimer()
        isGameOver = false
    }
}
