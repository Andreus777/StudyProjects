//
//  ViewController.swift
//  SystemViewControllers
//
//  Created by Андрей Фокин on 10.10.21.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func shareTapped(_ sender: UIButton) {
        
        guard let image = imageView.image else {return}
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func safariTapped(_ sender: UIButton) {
        
        if let url = URL(string: "http:/www.onliner.by") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func cameraTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose photo sourse", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
       
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
        
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {action in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
        alertController.addAction(cameraAction)
        }
          
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "Library", style: .default, handler: {action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
            
        present(alertController, animated: true, completion: nil)
        alertController.popoverPresentationController?.sourceView = sender
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        imageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func emailTapped(_ sender: UIButton) {
        
        guard MFMailComposeViewController.canSendMail() else {
            print("You can't send mail")
            return
        }
        
        let mailController = MFMailComposeViewController()
        mailController.mailComposeDelegate = self
        mailController.setMessageBody("This is test message text", isHTML: false)
        mailController.setSubject("Test subject")
        mailController.setToRecipients(["fokin@ttsg.by"])
        
        if let imageData = imageView.image,
           let jpegData = imageData.jpegData(compressionQuality: 0.9){
            mailController.addAttachmentData(jpegData, mimeType: "image/jpeg", fileName: "photo.jpg")
        }
        
        func mailComposeController (_ controller: MFMailComposeViewController, didFinish with: MFMailComposeResult, error: Error?) {
            dismiss(animated: true, completion: nil)
        }
        present(mailController, animated: true, completion: nil)
    }
    
    
    @IBAction func smsButtonTapped(_ sender: UIButton) {
        
        guard MFMessageComposeViewController.canSendText() else {
            print("Your App can't send SMS")
            return
        }
        
        let messageController = MFMessageComposeViewController()
        messageController.messageComposeDelegate = self
        messageController.body = "Text send"
        messageController.recipients = ["+375291825976"]
        
        present(messageController, animated: true, completion: nil)
        
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
}

