//
//  ViewController.swift
//  TConverter
//
//  Created by Андрей Фокин on 23.08.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var celsiumLabel: UILabel!
    @IBOutlet weak var farengeitLabel: UILabel!
    @IBOutlet weak var slider: UISlider!{
        didSet {
            slider.maximumValue = 100
            slider.minimumValue = 0
            slider.value = 0
        }
    }
    
    @IBAction func slaiderChanged(_ sender: UISlider) {
        let tempCelsius = Int(round(sender.value))
        celsiumLabel.text = "\(tempCelsius)ºC"
        farengeitLabel.text = "\(tempCelsius * 9/5 + 32)ºF"
    
    }
    
    
}

