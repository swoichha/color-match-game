//
//  ContentView.swift
//  color-match-game
//
//  Created by swoichha adhikari on 01/11/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Color Match")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Test your cognitive skills with the Stroop effect!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                NavigationLink("Start Game") {
                    GameView()
                }
                .buttonStyle(PrimaryButtonStyle())
                
                NavigationLink("High Scores") {
                    HighScoresView()
                }
                .buttonStyle(SecondaryButtonStyle())
                
                Spacer()
            }
            .navigationTitle("Color Match")
            .navigationBarHidden(true)
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.blue)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .padding(.horizontal)
    }
}

struct GameView: View {
    var body: some View {
        VStack {
            Text("Game Screen")
                .font(.title)
            Text("Coming soon...")
                .foregroundColor(.gray)
        }
        .navigationTitle("Game")
    }
}

struct HighScoresView: View {
    var body: some View {
        VStack {
            Text("High Scores")
                .font(.title)
            Text("Coming soon...")
                .foregroundColor(.gray)
        }
        .navigationTitle("High Scores")
    }
}
