//
//  Models.swift
//  color-match-game
//
//  Created by swoichha adhikari on 01/11/2025.
//

import SwiftUI

struct GameState {
    var score: Int
    var timeRemaining: Int
    var currentChallenge: (word: String, color: Color)
    var isGameActive: Bool
}

struct HighScores {
    var easy: Int
    var medium: Int
    var hard: Int
}

enum DifficultyLevel: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var timeLimit: Int {
        switch self {
        case .easy: return 60
        case .medium: return 30
        case .hard: return 15
        }
    }
    
    var pointsPerAnswer: Int {
        switch self {
        case .easy: return 1
        case .medium: return 2
        case .hard: return 3
        }
    }
}

struct ColorOption {
    let name: String
    let color: Color
    
    static let allColors: [ColorOption] = [
        ColorOption(name: "Red", color: .red),
        ColorOption(name: "Yellow", color: .yellow),
        ColorOption(name: "Green", color: .green),
        ColorOption(name: "Blue", color: .blue)
    ]
}
