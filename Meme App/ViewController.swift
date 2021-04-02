//
//  ViewController.swift
//  Meme App
//
//  Created by Ruslan Ismayilov on 3/20/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
//    Mark : Outlets
    @IBOutlet weak var imagePickerview: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    
    //    Properties
        let memeTextAttributes : [NSAttributedString.Key : Any ] = [
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 25)!,
            NSAttributedString.Key.strokeWidth : -5
        ];
        
        
        
    //    Mark : Life Cycles
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            topTextField.delegate = self
            bottomTextField.delegate = self
            topTextField.defaultTextAttributes = memeTextAttributes
            bottomTextField.defaultTextAttributes = memeTextAttributes
            topTextField.textAlignment = .center
            bottomTextField.textAlignment = .center
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
            subscribeToKeyboardNotification()
            
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            unsubscibeToKeyboardNotification()
        }

    @IBAction func share(_ sender: Any) {
        let sharedImage = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [sharedImage], applicationActivities: nil)
       
        activityController.completionWithItemsHandler = {
            activity,completed,items,error in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
            }
        self.present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        shareButton.isEnabled = false
        imagePickerview.image = nil
         topTextField.text = "TOP"
         bottomTextField.text = "BOTTOM"
    }
    
    
    
    @IBAction func pickAnImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imagePickerview.image = image
        } else if let editedImage = info[.editedImage] as? UIImage{
            imagePickerview.image  = editedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    
    func subscribeToKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func unsubscibeToKeyboardNotification(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ notification : Notification) {
        if bottomTextField.isFirstResponder {
        view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    @objc func keyboardWillHide(_ notification : Notification){
        
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification : Notification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        topTextField.resignFirstResponder()
        bottomTextField.resignFirstResponder()
        return true
    }
    
    func save(){
        _ = MemeModel(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerview.image!, memedImage: generateMemedImage())
    }
    
   
    
    func generateMemedImage() -> UIImage {

        self.navigationBar.isHidden = true
        self.toolBar.isHidden = true
        

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        self.navigationBar.isHidden = false
        self.toolBar.isHidden = false

        return memedImage
    }
    
}
    
     



    



