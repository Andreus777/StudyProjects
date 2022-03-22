//
//  ViewController.swift
//  LoginWithSegue
//
//  Created by Андрей Фокин on 14.09.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var userName: UITextField!
    @IBOutlet var forgotUserNameButton: UIButton!
    @IBOutlet var forgotPasswordButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let mySender = sender as? UIButton else {return}
        
        if mySender == forgotUserNameButton {
            segue.destination.navigationItem.title = "Forget UserName"
        } else if mySender == forgotPasswordButton {
            segue.destination.navigationItem.title = "Forget Password"
        } else {
            segue.destination.navigationItem.title = userName.text
        }
        
    }

    @IBAction func forgetUserNamePushed(_ sender: UIButton) {
        performSegue(withIdentifier: "Login", sender: sender)
    }
    
    @IBAction func forgetPAsswordPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "Login", sender: sender)
    }
    
}

