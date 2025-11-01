//
//  GameEngine.swift
//  color-match-game
//
//  Created by swoichha adhikari on 01/11/2025.
//
import SwiftUI
import Combine

class GameEngine: ObservableObject {
    @Published var gameState: GameState
    private var timer: Timer?
    private let difficulty: DifficultyLevel
    
    init(difficulty: DifficultyLevel) {
        self.difficulty = difficulty
        self.gameState = GameState(
            score: 0,
            timeRemaining: difficulty.timeLimit,
            currentChallenge: ("", .black),
            isGameActive: false
        )
        generateNewChallenge()
    }
    
    func startGame() {
        gameState.isGameActive = true
        startTimer()
    }
    
    func stopGame() {
        gameState.isGameActive = false
        timer?.invalidate()
        timer = nil
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.gameState.timeRemaining > 0 {
                self.gameState.timeRemaining -= 1
            } else {
                self.stopGame()
            }
        }
    }
    
    func generateNewChallenge() {
        let randomWordColor = ColorOption.allColors.randomElement()!
        let randomTextColor = ColorOption.allColors.randomElement()!
        
        gameState.currentChallenge = (
            word: randomWordColor.name,
            color: randomTextColor.color
        )
    }
    
    func checkAnswer(selectedColor: ColorOption) -> Bool {
        guard gameState.isGameActive else { return false }
        
        // Check if the selected color matches the WORD (not the text color)
        let isCorrect = selectedColor.name == gameState.currentChallenge.word
        
        if isCorrect {
            gameState.score += difficulty.pointsPerAnswer
        }
        
        generateNewChallenge()
        return isCorrect
    }
    
    func getTimePercentage() -> Double {
        Double(gameState.timeRemaining) / Double(difficulty.timeLimit)
    }
}
