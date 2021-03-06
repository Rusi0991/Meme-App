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
    
        
        
    //    Mark : Life Cycles
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            configure(topTextField, with: "TOP")
            configure(bottomTextField, with: "BOTTOM")
            tabBarController?.tabBar.isHidden = true
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
            subscribeToKeyboardNotification()
            
            
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
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
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    @IBAction func pickAnImage(_ sender: Any) {
        imagePicker(source: .photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        imagePicker(source: .camera)
    }
    
    
    func imagePicker(source : UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
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
        textField.resignFirstResponder()
        return true
    }
    
    func save(){
        // Create the meme
        let meme = MemeModel(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerview.image!, memedImage: generateMemedImage())
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        dismiss(animated: true, completion: nil)
    }
    
   
    
    func generateMemedImage() -> UIImage {

//        self.navigationBar.isHidden = true
//        self.toolBar.isHidden = true
        
        hideBars()

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

//        self.navigationBar.isHidden = false
//        self.toolBar.isHidden = false
        showBars()
        return memedImage
    }
    
    func hideBars(){
        navigationController?.navigationBar.isHidden = true
        toolBar.isHidden = true
        
    }
    func showBars(){
        navigationController?.navigationBar.isHidden = false
        toolBar.isHidden = false
        
    }
    
    func configure(_ textField: UITextField, with defaultText: String) {
        let memeTextAttributes : [NSAttributedString.Key : Any ] = [
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 25)!,
            NSAttributedString.Key.strokeWidth : -3.2
        ];
        
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.text = defaultText
        textField.delegate = self
       }
    
    
}
    
     



    



