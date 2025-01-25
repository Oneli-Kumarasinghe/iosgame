import SwiftUI

struct ContentView: View {
    
    @State private var squares: [Square]? = nil
    @State private var firstTappedIndex: Int? = nil
    @State private var isGameOver: Bool = false
    @State private var gameResult: String = ""
    @State private var canShuffle: Bool = false
    
    
    struct Square {
        var color: Color
    }
    
    var body: some View {
        VStack {
            Text("Match the Colors!")
                .font(.title)
                .padding()
            
            
            if let squares = squares {
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    ForEach(0..<9) { index in
                        Button(action: {
                            handleTileTap(index: index)
                        }) {
                            Rectangle()
                                .foregroundColor(squares[index].color)
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                        }
                        .disabled(isGameOver)
                    }
                }
                .padding()
            }
            
            
            if isGameOver {
                Text(gameResult)
                    .font(.title)
                    .bold()
                    .padding()
                
                Button("Play Again") {
                    restartGame()
                }
                .font(.title2)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            
            if !isGameOver && canShuffle {
                Button("Shuffle") {
                    shuffleTiles()
                }
                .font(.title2)
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .onAppear {
            
            generateRandomColors()
        }
    }
    
    
    private func handleTileTap(index: Int) {
        if let firstIndex = firstTappedIndex {
            
            if squares?[firstIndex].color == squares?[index].color {
                gameResult = "You Win!"
                canShuffle = false
            } else {
                gameResult = "You Lose!"
                canShuffle = false
            }
            isGameOver = true
        } else {
            // First tile tap
            firstTappedIndex = index
            canShuffle = false
        }
    }
    
    
    private func generateRandomColors() {
        
        let uniqueColors: [Color] = [.red, .green, .blue, .yellow, .purple, .orange, .pink, .gray, .teal]
        
        
        let pairColor = uniqueColors.randomElement()!
        
        
        var colorArray = [pairColor, pairColor]
        
        
        colorArray.append(contentsOf: uniqueColors.filter { $0 != pairColor })
        
        
        colorArray.shuffle()
        
        
        squares = colorArray.map { Square(color: $0) }
        canShuffle = true
    }
    
    
    private func shuffleTiles() {
        if let squares = squares {
            var colors = squares.map { $0.color }
            colors.shuffle()
            self.squares = colors.map { Square(color: $0) }
        }
    }
    
    private func restartGame() {
        
        squares = nil
        firstTappedIndex = nil
        isGameOver = false
        gameResult = ""
        canShuffle = false
        generateRandomColors()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
