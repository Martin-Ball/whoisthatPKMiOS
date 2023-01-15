//
//  GameModel.swift
//  who is that pokemon
//
//  Created by Martin Ballester on 14/01/2023.
//

import Foundation

struct GameModel {
    var score = 0
    
    // Review if ask is correct
    mutating func checkAnswer(_ userAnswer: String, _ correctAnswer: String) -> Bool {
        if userAnswer.lowercased() == correctAnswer.lowercased() {
            score += 1
            return true
        }
        return false
    }
    
    // GetScore
    func getScore() -> Int {
        return score
    }
    
    // SetScore
    mutating func setScore(score: Int) {
        self.score = score
    }
}
