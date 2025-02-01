import Foundation
import SwiftUI

enum DifficultyLevel {
    case beginner, hard
}

struct GameModel {
    var colors: [Color]
    var score: Int
    var highestScore: Int
    var timeRemaining: Int
    var timer: Timer?
    var gridSize: Int
    private var selectedIndices = [Int]()
   
    mutating func handleColorSelection(index: Int) -> Bool {
        if selectedIndices.count == 2 { return false }
       
        selectedIndices.append(index)
       
        if selectedIndices.count == 2 {
            let firstColor = colors[selectedIndices[0]]
            let secondColor = colors[selectedIndices[1]]
           
            if firstColor == secondColor {
                score += 10
                if score > highestScore {
                    highestScore = score
                    UserDefaults.standard.set(highestScore, forKey: "highestScore")
                }
                regenerateGrid(keepScore: true)
                return true
            } else {
                return false // Wrong match
            }
        }
        return true
    }

    private mutating func regenerateGrid(keepScore: Bool) {
        let currentScore = keepScore ? score : 0
        let currentHighestScore = highestScore
        let currentDifficulty = gridSize == 4 ? DifficultyLevel.beginner : DifficultyLevel.hard
       
        self = GameModel.generateNewGame(difficulty: currentDifficulty)
        self.score = currentScore
        self.highestScore = currentHighestScore
    }

    mutating func restartGame() {
        regenerateGrid(keepScore: false)
    }

    static func generateNewGame(difficulty: DifficultyLevel) -> GameModel {
        var colors = [Color]()
        let availableColors: [Color] = [.red, .blue, .green, .orange, .purple, .yellow, .gray, .pink, .brown]
       
        let gridSize = difficulty == .beginner ? 4 : 9
       
        // Select unique colors
        var selectedColors = Array(availableColors.shuffled().prefix(gridSize - 1))
       
        // Pick one random color to be duplicated
        let duplicateColor = selectedColors.randomElement()!
        selectedColors.append(duplicateColor)
       
        colors = selectedColors.shuffled()
       
        return GameModel(
            colors: colors,
            score: 0,
            highestScore: UserDefaults.standard.integer(forKey: "highestScore"),
            timeRemaining: 30,
            timer: nil,
            gridSize: gridSize
        )
    }
}
