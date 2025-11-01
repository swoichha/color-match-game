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


struct HighScoresView: View {
    @State private var highScores = HighScores(easy: 0, medium: 0, hard: 0)
    
    var body: some View {
        VStack(spacing: 30) {
            Text("High Scores")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            VStack(spacing: 20) {
                ScoreRow(difficulty: .easy, score: highScores.easy)
                ScoreRow(difficulty: .medium, score: highScores.medium)
                ScoreRow(difficulty: .hard, score: highScores.hard)
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button("Reset Scores") {
                // Will implement reset functionality later
                highScores = HighScores(easy: 0, medium: 0, hard: 0)
            }
            .buttonStyle(SecondaryButtonStyle())
            .padding()
        }
        .navigationTitle("High Scores")
    }
}

struct ScoreRow: View {
    let difficulty: DifficultyLevel
    let score: Int
    
    var body: some View {
        HStack {
            Text(difficulty.rawValue)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            
            Text("\(score) points")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
