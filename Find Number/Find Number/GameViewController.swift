//
//  GameViewController.swift
//  Find Number
//
//  Created by Андрей Фокин on 31.07.21.
//

import UIKit

class GameViewController: UIViewController {

    
    @IBOutlet var Buttons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in Buttons{
            button.backgroundColor = .green
            button.tintColor = .black
        }
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        
        sender.isHidden = true
        print (sender.currentTitle!)
        
    }
    

}
    


