//
//  GuidePageView.swift
//  iosgame
//
//  Created by Theniya Kumarasinghe on 2025-02-01.
//

import Foundation
import SwiftUI

struct GuidePageView: View {
    var body: some View {
        VStack {
            Text("How to Play")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("1. The game generates a 3x3 matrix of random colors.")
            Text("2. Your goal is to select the matched colors within the given time limit.")
            Text("3. Try to get as many correct matches as possible!")
                .padding(.top, 30)
            
            Button("Close") {
                // Close guide
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

