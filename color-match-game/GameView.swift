//
//  GameView.swift
//  color-match-game
//
//  Created by swoichha adhikari on 01/11/2025.
//

import SwiftUI

struct GameView: View {
    @State private var selectedDifficulty: DifficultyLevel?
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Select Difficulty")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 40)
            
            Text("Choose your challenge level")
                .foregroundColor(.gray)
            
            Spacer()
            
            VStack(spacing: 20) {
                ForEach(DifficultyLevel.allCases, id: \.self) { difficulty in
                    DifficultyButton(
                        difficulty: difficulty,
                        isSelected: selectedDifficulty == difficulty,
                        action: {
                            selectedDifficulty = difficulty
                        }
                    )
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            NavigationLink(
                destination: GameSessionView(difficulty: selectedDifficulty ?? .easy),
                label: {
                    Text("Start Game")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedDifficulty == nil ? Color.gray : Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            )
            .disabled(selectedDifficulty == nil)
        }
        .padding()
    }
}

struct DifficultyButton: View {
    let difficulty: DifficultyLevel
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(difficulty.rawValue)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("\(difficulty.timeLimit) seconds • \(difficulty.pointsPerAnswer) pt/answer")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
            .padding()
            .background(isSelected ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
        }
        .foregroundColor(.primary)
    }
}
