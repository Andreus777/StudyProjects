//
//  ViewController.swift
//  TrafficSegues
//
//  Created by Андрей Фокин on 14.09.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var pushToYellow: UIButton!
    @IBOutlet var pushToGreen: UIButton!
    @IBOutlet var switchLabel: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pushToGreen.tintColor = .black
        pushToYellow.tintColor = .black
        
    }
    
    
    @IBAction func yellowButtonPushed(_ sender: Any) {
        if switchLabel.isOn {
            performSegue(withIdentifier: "Yellow", sender: nil)
        }
    }
    
    @IBAction func greenButtonPushed(_ sender: Any) {
        if switchLabel.isOn{
            performSegue(withIdentifier: "Green", sender: nil)
        }
    }
    
}

    
