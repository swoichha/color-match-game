//
//  GameSessionView.swift
//  color-match-game
//
//  Created by swoichha adhikari on 01/11/2025.
//

import SwiftUI

struct GameSessionView: View {
    let difficulty: DifficultyLevel
    @StateObject private var gameEngine: GameEngine
    @Environment(\.presentationMode) var presentationMode
    
    init(difficulty: DifficultyLevel) {
        self.difficulty = difficulty
        _gameEngine = StateObject(wrappedValue: GameEngine(difficulty: difficulty))
    }
    
    var body: some View {
        VStack(spacing: 30) {
            // Header with score and timer
            HStack {
                VStack {
                    Text("Score")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("\(gameEngine.gameState.score)")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack {
                    Text("Time")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("\(gameEngine.gameState.timeRemaining)s")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(timeColor)
                }
                
                Spacer()
                
                VStack {
                    Text("Difficulty")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(difficulty.rawValue)
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            .padding(.horizontal)
            
            // Current challenge
            VStack(spacing: 20) {
                Text("Tap the color that matches the WORD")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Text(gameEngine.gameState.currentChallenge.word)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(gameEngine.gameState.currentChallenge.color)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
            }
            
            // Color buttons
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 20) {
                ForEach(ColorOption.allColors, id: \.name) { colorOption in
                    Button(action: {
                        _ = gameEngine.checkAnswer(selectedColor: colorOption)
                    }) {
                        Text(colorOption.name)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(height: 80)
                            .frame(maxWidth: .infinity)
                            .background(colorOption.color)
                            .cornerRadius(12)
                    }
                    .disabled(!gameEngine.gameState.isGameActive)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Game control buttons
            if !gameEngine.gameState.isGameActive {
                VStack(spacing: 15) {
                    if gameEngine.gameState.timeRemaining == 0 {
                        Text("Time's Up!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    }
                    
                    Button(gameEngine.gameState.timeRemaining == difficulty.timeLimit ? "Start Game" : "Play Again") {
                        gameEngine.startGame()
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    
                    Button("Back to Menu") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .buttonStyle(SecondaryButtonStyle())
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitle("Color Match", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onDisappear {
            gameEngine.stopGame()
        }
    }
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .foregroundColor(.blue)
        }
    }
    
    private var timeColor: Color {
        let percentage = gameEngine.getTimePercentage()
        if percentage > 0.5 { return .green }
        if percentage > 0.25 { return .orange }
        return .red
    }
}
