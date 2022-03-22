//
//  ViewController.swift
//  MusicWireframe
//
//  Created by Андрей Фокин on 24.10.21.
//

import UIKit

class ViewController: UIViewController {
    
    var isPalying: Bool = true {
        didSet{
            stopPauseButton.isSelected = isPalying
        }
    }
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var reverseButton: UIButton!
    @IBOutlet weak var stopPauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var reverseBackground: UIView!
    @IBOutlet weak var stopPauseBackground: UIView!
    @IBOutlet weak var forwardBackGround: UIView!
    @IBOutlet var viewIm: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewIm.backgroundColor = .orange
        [reverseBackground, stopPauseBackground, forwardBackGround].forEach { view in
            view?.layer.cornerRadius = (view?.frame.height)!/2
            view?.clipsToBounds = true
            view?.alpha = 0.0
        }
        
    }

    @IBAction func playStopButtonTapped(_ sender: UIButton) {
        isPalying.toggle()
        if isPalying {
            sender.setImage(UIImage(named: "pencil"), for: .selected)
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: [], animations: {self.image.transform = CGAffineTransform.identity}, completion: nil)
            
        } else {
            sender.imageView?.image = UIImage(named: "pause.fill")
            UIView.animate(withDuration: 0.5, animations: {
                self.image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
            
        }
        
    }
    
    @IBAction func TouchUp(_ sender: UIButton) {
        let buttonBackground: UIView
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackground
        case forwardButton:
            buttonBackground = forwardBackGround
        case stopPauseButton:
            buttonBackground = stopPauseBackground
        
        default: return
        }
        UIView.animate(withDuration: 0.25, animations: {
            buttonBackground.alpha = 0.0
            buttonBackground.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            sender.transform = CGAffineTransform.identity
        }) { (_) in buttonBackground.transform = CGAffineTransform.identity
        }
       
    }
    
    @IBAction func TouchDown(_ sender: UIButton) {
        
        let buttonBackground: UIView
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackground
        case forwardButton:
            buttonBackground = forwardBackGround
        case stopPauseButton:
            buttonBackground = stopPauseBackground
        default: return
        }
        UIView.animate(withDuration: 0.25, animations: {
            buttonBackground.alpha = 0.3
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
    }
}
 
    

