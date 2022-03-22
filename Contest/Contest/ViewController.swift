//
//  ViewController.swift
//  Contest
//
//  Created by Андрей Фокин on 25.10.21.
//

import UIKit

class ViewController: UIViewController {
   
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func submitTapped(_ sender: UIButton) {
        
        if textField.text?.isEmpty == true {
            UIView.animate(withDuration: 0.3, animations: {
                self.textField.transform = CGAffineTransform(translationX: 20, y: 0)
            }) { (_) in UIView.animate(withDuration: 0.3, animations: {
                self.textField.transform = CGAffineTransform.identity
            })}
            
        } else {
            performSegue(withIdentifier: "registration", sender: sender)
        }
        
    }
    
}

