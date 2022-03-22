//
//  Game.swift
//  Apple Pie
//
//  Created by Андрей Фокин on 11.09.21.
//

import Foundation


struct Game {
    
    var incorrectMovesLeft: Int
    var word: String
    var guessLetter: [Character]
    
    var score: Int {
        var gameScore = 0
        for letter in word {
            if guessLetter.contains(letter){
                gameScore += 5
            } else if !guessLetter.contains(letter){
                //gameScore -= 5
            }
        }
        return gameScore
    }
    
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessLetter.contains(letter){
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(letter: Character){
        guessLetter.append(letter)
        
        if !word.contains(letter){
            incorrectMovesLeft -= 1
        }
    }
}
