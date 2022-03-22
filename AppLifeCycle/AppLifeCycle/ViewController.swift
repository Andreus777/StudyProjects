//
//  ViewController.swift
//  AppLifeCycle
//
//  Created by Андрей Фокин on 21.09.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var didFinishLaunchingWithOptions: UILabel!
    @IBOutlet var configurationForConnecting: UILabel!
    @IBOutlet var willConnectTo: UILabel!
    @IBOutlet var sceneDidBecomeActive: UILabel!
    @IBOutlet var sceneWillResignActive: UILabel!
    @IBOutlet var sceneWillEnterForeground: UILabel!
    @IBOutlet var sceneDidEnterBackground: UILabel!
    

    var willConnect = 0
    var sceneDidBecomeAct = 0
    var sceneWillResignAct = 0
    var sceneWillEnterForegro = 0
    var sceneDidEnterBackgr = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    func updateUI() {
        didFinishLaunchingWithOptions.text = "The app has launched \(appDelegate.launchCount) times"
        configurationForConnecting.text = "Configuration for connect \(appDelegate.cofigurationForConnectingCount) times"
        willConnectTo.text = "Will connect \(willConnect) times"
        sceneDidBecomeActive.text = "sceneDidBecomeActive \(sceneDidBecomeAct) times"
        sceneWillResignActive.text = "sceneWillResignActive \(sceneWillResignAct) times"
        sceneWillEnterForeground.text = "sceneWillEnterForeground \(sceneWillEnterForegro) times"
        sceneDidEnterBackground.text = "sceneDidEnterBackground \(sceneDidEnterBackgr) times"
    }

}

