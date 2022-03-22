//
//  ViewController.swift
//  Scrolling Form
//
//  Created by Андрей Фокин on 28.09.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKbNotification()
    }

    
    func registerForKbNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWasHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
   @objc func keyBoardWasShown(_ notification: Notification){
        
       guard let info = notification.userInfo,
             let keyBoardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {return}
       
       let kbFrame = keyBoardFrameValue.cgRectValue
       let kbSize = kbFrame.size
        
       let contentInsets  = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
       scrollView.contentInset = contentInsets
       scrollView.scrollIndicatorInsets = contentInsets

    }
    
    @objc func keyBoardWasHidden(_ notification: Notification){
        
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}



