//
//  ViewController.swift
//  PassDataProject
//
//  Created by Андрей Фокин on 24.08.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var resultLable: UILabel!
    
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "mySegue", sender: nil)
    }
    
    @IBAction func unwindSegueToMainScreen(segue: UIStoryboardSegue){
        guard let svc = segue.source as? SecondViewController else { return }
        self.resultLable.text = svc.label.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? SecondViewController else {return}
        
        dvc.login = loginTF.text
    }
}

