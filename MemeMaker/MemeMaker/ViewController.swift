//
//  ViewController.swift
//  MemeMaker
//
//  Created by Андрей Фокин on 29.08.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topSegmentedCotrol: UISegmentedControl!
    @IBOutlet weak var bottomSegmentedCotrol: UISegmentedControl!
    @IBOutlet weak var topCaptionLabel: UILabel!
    @IBOutlet weak var bottomCaptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTopSegmentControl()
        configBottomSementControl()
        setCaptions()
    
    }

    @IBAction func segmentControlBT(_ sender: UISegmentedControl) {
        setCaptions()
    }
    
    @IBAction func dragTopLabel(_ sender: UIPanGestureRecognizer) {
        if sender.state == .changed {
            topCaptionLabel.center =
                sender.location(in: view)
        }
        
    }
    
    @IBAction func dragBottomLabel(_ sender: UIPanGestureRecognizer) {
        
        if sender.state == .changed {
            bottomCaptionLabel.center = sender.location(in: view)
        }
    }
    
    var topChoises = [CaptionOption(emoji: "😎", caption: "You know what’s cool?"),
                      CaptionOption(emoji: "😖", caption: "You know what makes me mad?"),
                      CaptionOption(emoji: "😍", caption: "You know what I love")]
    
    
    var bottonChoises = [CaptionOption]()
    
    let firstBottom = CaptionOption(emoji: "🐱", caption: "Cats wearing heats")
    let secondBottom = CaptionOption(emoji: "🐶", caption: "Dogs carrying logs")
    let thirdBottom = CaptionOption(emoji: "🐵", caption: "Monkeys beeing funky")
    
    
    
    func configTopSegmentControl() {
        topSegmentedCotrol.removeAllSegments()
        for choise in topChoises {
            topSegmentedCotrol.insertSegment(withTitle: choise.emoji, at: topChoises.count, animated: false)
        }
        topSegmentedCotrol.selectedSegmentIndex = 0
    }
    
    func configBottomSementControl(){
        bottomSegmentedCotrol.removeAllSegments()
        bottonChoises.append(firstBottom)
        bottonChoises.append(secondBottom)
        bottonChoises.append(thirdBottom)
        
        for choise in bottonChoises{
            bottomSegmentedCotrol.insertSegment(withTitle: choise.emoji, at: bottonChoises.count, animated: false)
        }
        bottomSegmentedCotrol.selectedSegmentIndex = 1
    }

    func setCaptions(){
            let topIndex = topSegmentedCotrol.selectedSegmentIndex
        topCaptionLabel.text = topChoises[topIndex].caption
    
            let bottomIndex = bottomSegmentedCotrol.selectedSegmentIndex
        bottomCaptionLabel.text = bottonChoises[bottomIndex].caption
        }
    }


