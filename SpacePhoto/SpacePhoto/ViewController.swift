//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Андрей Фокин on 28.10.21.
//

import UIKit

class ViewController: UIViewController {
    
    let photoInfoController = PhotoInfoController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLB: UILabel!
    @IBOutlet weak var copyrightLB: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ""
        imageView.image = UIImage(systemName: "photo.on.rectangle")
        descriptionLB.text = ""
        copyrightLB.text = ""
        
        photoInfoController.fetchFotoInfo { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let photoInfo):
                    self.updateUI(with: photoInfo)
                case .failure(let error):
                    self.updateUI(with: error)
                }
                
            }
        }
    }
        
        
        func updateUI(with photoInfo: PhotoInfo){
            photoInfoController.fetchPhoto(my: photoInfo.url, completion: {(result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        self.title = photoInfo.title
                        self.imageView.image = image
                        self.descriptionLB.text = photoInfo.description
                        self.copyrightLB.text = photoInfo.copyright
                    case .failure(let error):
                        self.updateUI(with: error)
                    }
                }
            })
        }
        
        func updateUI(with error: Error){
            title = "Error fetching photoInfo"
            imageView.image = UIImage(systemName: "exclamationmark.octagon")
            descriptionLB.text = error.localizedDescription
            copyrightLB.text = ""
        }
    }
    

    



