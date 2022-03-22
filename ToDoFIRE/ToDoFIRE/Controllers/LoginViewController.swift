//
//  ViewController.swift
//  ToDoFIRE
//
//  Created by Андрей Фокин on 25.09.21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var ref: DatabaseReference!

    @IBOutlet weak var warningLB: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(withPath: "users")
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        warningLB.alpha = 0
        
        Auth.auth().addStateDidChangeListener ({[weak self] auth, user in
            if user != nil {
                self?.performSegue(withIdentifier: "taskSegue", sender: nil)
            }
        })
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @objc func keyBoardDidShow(notification: Notification){
        
        guard let userInfo = notification.userInfo else {return}
        
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + kbFrameSize.height)
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }
    
    
    @objc func keyBoardDidHide(notification: Notification) {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    
    func displayWarningLabel(withText text: String){
        warningLB.text = text
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {[weak self] in
                        self?.warningLB.alpha = 1
        }) { [weak self] complete in
            self?.warningLB.alpha = 0
        }
    }

    @IBAction func loginTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            displayWarningLabel(withText: "Incorrect data")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: {[weak self](user, error) in
            if error != nil {
                self?.displayWarningLabel(withText: "error occured")
                return
            }
            
            if user != nil {
                self?.performSegue(withIdentifier: "taskSegue", sender: nil)
                return
            }
            self?.displayWarningLabel(withText: "No such user")
        } )
    }
    
    
    @IBAction func registerTapped(_ sender: Any) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else
           {
            displayWarningLabel(withText: "Incorrect data")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] user, error in
            
           guard error == nil, user != nil else {
                print(error!.localizedDescription)
                return
            }
        
            let userRef = self?.ref.child((user?.user.uid)!)
            userRef?.setValue(["email": user?.user.email])
            
        })
        
    }
}




