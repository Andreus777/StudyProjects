//
//  ViewController.swift
//  LightON
//
//  Created by Андрей Фокин on 3.09.21.
//

import UIKit

class ViewController: UIViewController {
    
    var lightOn = true

    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
     func updateUI() {
        view.backgroundColor = lightOn ? .white : .black
     }
            
    
    @IBAction func buttonPressed(_ sender: Any) {
        lightOn.toggle()
        updateUI()
    }
    
}

