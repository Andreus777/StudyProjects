//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Андрей Фокин on 17.09.21.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    

    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    
    @IBOutlet var switch1: UISwitch!
    @IBOutlet var switch2: UISwitch!
    @IBOutlet var switch3: UISwitch!
    @IBOutlet var switch4: UISwitch!
    
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var minLable: UILabel!
    @IBOutlet var maxLabel: UILabel!
    @IBOutlet var slider: UISlider!
    
    

    @IBOutlet var showQuetion: UILabel!
    @IBOutlet var progress: UIProgressView!
    
    
    // индекс массива с вопросами
    var questionIndex = 0
    // массив для сохранения ответов юзера
    var choosenAnswer: [Answer] = []
    
    func updateUI(){
        questions.shuffle()
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        navigationItem.title = "Question # \(questionIndex + 1)"
        
        let question = questions.shuffled()[questionIndex]
        let answer = question.answer
        progress.setProgress(Float(questionIndex)/Float(questions.count), animated: true)
        showQuetion.text = question.text
        
        func updateSingleQuestionButtons(using answers: [Answer]){
            singleStackView.isHidden = false
            button1.setTitle(answers[0].text, for: .normal)
            button2.setTitle(answers[1].text, for: .normal)
            button3.setTitle(answers[2].text, for: .normal)
            button4.setTitle(answers[3].text, for: .normal)
        }
        
        func updateMuiltipleQuestionButtons(using answers: [Answer]){
            multipleStackView.isHidden = false
            switch1.isOn = false
            switch2.isOn = false
            switch3.isOn = false
            switch4.isOn = false
            label1.text = answers[0].text
            label2.text = answers[1].text
            label3.text = answers[2].text
            label4.text = answers[3].text
        }
        
        func updateRangeStackQuestion(using answers: [Answer]){
            rangedStackView.isHidden = false
            slider.isEnabled = true
            slider.setValue(0.5, animated: true)
            minLable.text = answers.first?.text
            maxLabel.text = answers.last?.text
        }
        
        switch question.type {
        case .single:
            updateSingleQuestionButtons(using: answer)
        case .multiple:
            updateMuiltipleQuestionButtons(using: answer)
        case .ranged:
            updateRangeStackQuestion(using: answer)
           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // сохранение результатов после первого вопроса
    @IBAction func singleStackButtonPushed(_ sender: UIButton) {
        let savedAnswer = questions[questionIndex].answer
        switch sender {
        case button1:
            choosenAnswer.append(savedAnswer[0])
        case button2:
            choosenAnswer.append(savedAnswer[1])
        case button3:
            choosenAnswer.append(savedAnswer[2])
        case button4:
            choosenAnswer.append(savedAnswer[3])
        default: break
        }
        nextQuestion()
    }
   
    //сохранение результатов после второго вопроса
    @IBAction func multipleSwitchChanged() {
        let savedAnswer = questions[questionIndex].answer
        if switch1.isOn {
            choosenAnswer.append(savedAnswer[0])
        }
        if switch2.isOn {
            choosenAnswer.append(savedAnswer[1])
        }
        if switch3.isOn {
            choosenAnswer.append(savedAnswer[2])
        }
        if switch4.isOn {
            choosenAnswer.append(savedAnswer[3])
        }
        nextQuestion()
    }
    
    //сохранение результатов после третьего вопроса
    @IBAction func rangeSliderChange() {
        
        let savedAnswer = questions[questionIndex].answer
        
        let index = Int(round(slider.value * Float(savedAnswer.count - 1)))
        choosenAnswer.append(savedAnswer[index])
        nextQuestion()
    }
    
    
    
    func nextQuestion(){
        questionIndex += 1
        
        if questionIndex < questions.count{
            updateUI()
        } else {
            performSegue(withIdentifier: "Result", sender: nil)
        }
    }
    
    
    @IBSegueAction func showResult(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: choosenAnswer)
    }
    
    
    var questions: [Question] = [Question(
                                         text: "Wich food do you like?",
                                         type: .single,
                                         answer: [Answer(text: "Meat", type: .dog),
                                                  Answer(text: "Fish", type: .cat),
                                                  Answer(text: "Carrot", type: .rabbit),
                                                  Answer(text: "Corn", type: .turtle)]),
                                Question(
                                    text: "Which activities do you enjoy",
                                    type: .multiple,
                                    answer: [Answer(text: "Sleeping", type: .cat),
                                             Answer(text: "Eating", type: .dog),
                                             Answer(text: "Swimming", type: .turtle),
                                             Answer(text: "Cuddling", type: .rabbit)]),
                                Question(
                                    text: "How much do you enjoy car rides?",
                                    type: .ranged,
                                    answer: [Answer(text: "I dislike them", type: .cat),
                                             Answer(text: "I get a little nervous", type: .rabbit),
                                             Answer(text: "I barely notice them", type: .turtle),
                                             Answer(text: "I love them", type: .dog)])
                                      
    ]

    
}

