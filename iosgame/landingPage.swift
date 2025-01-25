//
//  landingPage.swift
//  iosgame
//
//  Created by Theniya Kumarasinghe on 2025-01-25.
//

import SwiftUI

struct LandingPage: View {
    @State private var isGameActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to the Tile Matching Game!")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Spacer()
                
                
                NavigationLink(destination: ContentView()) {
                    Text("Start Game")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle()) 
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
