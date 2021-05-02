//
//  DetailViewController.swift
//  Meme App
//
//  Created by Ruslan Ismayilov on 4/28/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!
    var meme : MemeModel?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func updateView(){
        guard let meme = meme else{return}
        detailImage.image = meme.memedImage
    }
    
}
