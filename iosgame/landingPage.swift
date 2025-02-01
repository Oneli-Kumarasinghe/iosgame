import SwiftUI

struct LandingPageView: View {
    @State private var isShowingGuide = false
    @State private var highestScore = UserDefaults.standard.integer(forKey: "highestScore")
    @State private var selectedDifficulty: DifficultyLevel?
   
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Color Match!")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Select Difficulty:")
                    .font(.title2)
                    .padding(.top, 20)
               
                HStack {
                    Button(action: {
                        selectedDifficulty = .beginner
                    }) {
                        Text("Beginner (2x2)")
                            .padding()
                            .frame(width: 140)
                            .background(selectedDifficulty == .beginner ? Color.green : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                   
                    Button(action: {
                        selectedDifficulty = .hard
                    }) {
                        Text("Hard (3x3)")
                            .padding()
                            .frame(width: 140)
                            .background(selectedDifficulty == .hard ? Color.red : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()

                if let difficulty = selectedDifficulty {
                    NavigationLink(destination: GameView(difficulty: difficulty)) {
                        Text("Start Game")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }

                Button("How to Play") {
                    isShowingGuide.toggle()
                }
                .sheet(isPresented: $isShowingGuide) {
                    GuidePageView()
                }

                Text("Highest Score: \(highestScore)")
                    .padding(.top, 10)
            }
            .navigationBarHidden(true)
        }
    }
}
