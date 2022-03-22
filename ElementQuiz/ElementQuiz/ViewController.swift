//
//  ViewController.swift
//  ElementQuiz
//
//  Created by Андрей Фокин on 30.08.21.
//

import UIKit

enum Mode {
    case flashCard
    case quiz
}

enum State {
    case answer
    case question
    case score
}



class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var showAnswer: UIButton!
    
    var mode: Mode = .flashCard {
        didSet {
            switch mode {
            case .flashCard:
                setupFlashCArd()
            case .quiz:
                setupQuiz()
            }
            updateUI()
        }
    }

    var state: State = .question
    
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let playerText = textField.text!
        if playerText.lowercased() == elementList[currentElementIndex].lowercased() {
            answerIsCorrect = true
            correctAnswerCount += 1
        } else {
            answerIsCorrect = false
        }
        state = .answer
        updateUI()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mode = .flashCard
    }
    
    @IBAction func showAnswer(_ sender: UIButton) {
        state = .answer
        updateUI()
    }
    
    @IBAction func next(_ sender: UIButton) {
        currentElementIndex += 1
        if currentElementIndex >= elementList.count{
            currentElementIndex = 0
            if mode == .quiz {
                state = .score
                updateUI()
                return
            }
            currentElementIndex = 0
        }
        state = .question
        updateUI()
    }
    
    @IBAction func switchModes(_ sender: UISegmentedControl) {
        
        if modeSelector.selectedSegmentIndex == 0 {
            mode = .flashCard
        } else {
            mode = .quiz
        }
    }
    
    
    var fixedElementList = ["Carbon", "Gold", "Chlorine","Sodium"]
    var elementList: [String] = []
    
    
    var currentElementIndex = 0
    
    
    // updating UI for FlashCard type game
    
    func updateFlashCardUI(element: String) {
        showAnswer.isHidden = false
        nextButton.isEnabled = true
        nextButton.setTitle("Next Element", for: .normal)
        modeSelector.selectedSegmentIndex = 0
        textField.isHidden = true
        textField.resignFirstResponder()
        if state == .answer {
            answerLabel.text = element
        } else {
            answerLabel.text = "?"
        }
    }
    
    // updating UI for Quiz type game
    
    func updateQuizUI(element: String) {
        if currentElementIndex == elementList.count-1 {
            nextButton.setTitle("Show Score", for: .normal)
        } else {
            nextButton.setTitle("Next Question", for: .normal)
        }
        
        switch state {
        case .answer:
            nextButton.isEnabled = true
        case .question  :
            nextButton.isEnabled = false
        case .score:
            nextButton.isEnabled = false
        }
        
        modeSelector.selectedSegmentIndex = 1
        textField.isHidden = false
        showAnswer.isHidden = true
       
        switch state {
        case .question:
            textField.isEnabled = true
            textField.text = ""
            textField.becomeFirstResponder()
        case .answer:
            textField.isEnabled = false
            textField.resignFirstResponder()
        case .score:
            textField.isHidden = true
            textField.resignFirstResponder()
        
    }
        
        switch state {
        case .question:
            answerLabel.text = ""
        case .answer:
            if answerIsCorrect {
                answerLabel.text = "Correct"
            } else {
                answerLabel.text = "❌\n Correct answer is \(element)"
            }
        case .score:
            answerLabel.text = ""
            
        }
        if state == .score{
            displayScoreAlert()
        }
    }
    
    // common update UI (Quiz + FlashCard)
    
    func updateUI() {
        view.backgroundColor = .systemGray
        showAnswer.backgroundColor = .white
        nextButton.backgroundColor = .white
        let element = elementList[currentElementIndex]
        let image = UIImage(named: element)
        imageView.image = image
        switch mode {
        case .quiz:
            updateQuizUI(element: element)
        case .flashCard:
            updateFlashCardUI(element: element)
        }
    }
    
    // make Alert
    
    func displayScoreAlert() {
       
        // make Alert Controller
        let alert = UIAlertController(title: "Quiz score", message: "Your score is \(correctAnswerCount) out of \(elementList.count).", preferredStyle: .alert)
        
        // Make Alert action
        let dismissAlert = UIAlertAction(title: "OK", style: .default , handler: scoredAlertDismissed (_:))
        
        alert.addAction(dismissAlert)
        
        // present Alert to User
        present(alert, animated: true, completion: nil)
    }
    
    func scoredAlertDismissed(_ action: UIAlertAction) {
        mode = .flashCard
    }
    
    func setupQuiz(){
        elementList = fixedElementList.shuffled()
        state = .question
        currentElementIndex = 0
        answerIsCorrect = false
        correctAnswerCount = 0
    }
    
    func setupFlashCArd() {
        elementList = fixedElementList
        state = .question
        currentElementIndex = 0
    }
    
}


