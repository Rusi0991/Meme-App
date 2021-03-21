//
//  ViewController.swift
//  Meme App
//
//  Created by Ruslan Ismayilov on 3/20/21.
//

import UIKit

class ViewController: UIViewController {
    
//    Mark : Outlets
    @IBOutlet weak var imagePickerview: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

  
    @IBAction func pickAnImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        present(pickerController, animated: true, completion: nil)
    }
}


