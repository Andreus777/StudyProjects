//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Андрей Фокин on 17.09.21.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var resultTextLabel: UILabel!
    
    
    
    var responses:[Answer]

    override func viewDidLoad() {
        super.viewDidLoad()
        calculateResult()
        navigationItem.hidesBackButton = true
    }
    
    init?(coder: NSCoder, responses: [Answer]){
        self.responses = responses
        super.init(coder: coder)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func calculateResult(){
        let frequencyOfAnswer = responses.reduce(into: [:]) {
            (counts, answer) in counts[answer.type, default: 0] += 1
        }
        
        let mostCommonAnswer = frequencyOfAnswer.sorted {$0.1 > $1.1}.first?.key
    
        resultLabel.text = "You are a \(mostCommonAnswer!.rawValue)!"
        resultTextLabel.text = mostCommonAnswer?.defenition
    }
    
   
}
    
    
    

