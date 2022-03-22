//
//  ViewController.swift
//  ColorMix
//
//  Created by Андрей Фокин on 25.08.21.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var redSwitch: UISwitch!
    @IBOutlet weak var greenSwitch: UISwitch!
    @IBOutlet weak var blueSwitch: UISwitch!
    
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    
    func changeColor(){
        var redColor: CGFloat = 0
        var blueColor: CGFloat = 0
        var greenColor: CGFloat = 0
        if redSwitch.isOn {
            redColor = CGFloat(redSlider.value)
        }
        if blueSwitch.isOn {
            blueColor = CGFloat(blueSlider.value)
        }
        if greenSwitch.isOn {
            greenColor = CGFloat(greenSlider.value)
        }
        
        colorView.backgroundColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1)
    }
    
    func updateControls() {
        redSlider.isEnabled = redSwitch.isOn
        blueSlider.isEnabled = blueSwitch.isOn
        greenSlider.isEnabled = greenSwitch.isOn
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.borderWidth = 5
        colorView.layer.cornerRadius = 20
        colorView.layer.borderColor = UIColor.black.cgColor
        changeColor()
        updateControls()
    }

    @IBAction func switchChanged(_ sender: UISwitch) {
        changeColor()
        updateControls()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        changeColor()
    }
    
    
    @IBAction func reset(_ sender: UIButton) {
        redSwitch.isOn = false
        blueSwitch.isOn = false
        greenSwitch.isOn = false
        
        redSlider.value = 1
        blueSlider.value = 1
        greenSlider.value = 1
        changeColor()
        updateControls()
    }
}

