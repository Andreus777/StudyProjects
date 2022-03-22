//
//  ViewController.swift
//  Apple Pie
//
//  Created by Андрей Фокин on 10.09.21.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["Swift", "Program"]
    
    let incorrectMovesAllowed = 7
    let bonusScore = 0
    var gameScored = 0
    
    var wins = 0 {
        didSet{
            newRound()
        }
    }
    
    var loses = 0 {
        didSet {
            newRound()
        }
    }

    @IBOutlet var tree: UIImageView!
    @IBOutlet var word: UILabel!
    @IBOutlet var score: UILabel!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var bonus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = Character(sender.title(for: .normal)!.lowercased())
        newGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    var newGame: Game!
    
    
    func newRound() {
        if !listOfWords.isEmpty {
        let newWord = listOfWords.removeFirst().lowercased()
        print(newWord)
        newGame = Game(incorrectMovesLeft: incorrectMovesAllowed, word: newWord, guessLetter: [])
        updateButtons(true)
        updateUI()
        } else {
            updateButtons(false)
            
        }
    }
    
    func updateUI(){
        
        let letters = newGame.formattedWord.map{String($0)}
        
        let wordWithSpacing = letters.joined(separator: " ")
        gameScored = newGame.score
        word.text = wordWithSpacing
        score.text = "Wins: \(wins), Loses: \(loses)"
        tree.image = UIImage(named: "Tree \(newGame.incorrectMovesLeft)")
        bonus.text = "Your score is: \(gameScored)"
    
    }
    
    func updateGameState() {
        
        if newGame.incorrectMovesLeft == 0 {
            loses += 1
            gameScored -= 10
            //updateButtons(true)
        } else if newGame.word == newGame.formattedWord {
            wins += 1
            gameScored += 10
            updateButtons(true)
        } else {
            updateUI()
         
        }
    }
    
    func updateButtons(_ enable: Bool) {
        
        for button in buttons {
            button.isEnabled = enable
            
        }
    }
    
    
}

   

