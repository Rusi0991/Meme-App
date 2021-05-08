//
//  DetailViewController.swift
//  Meme App
//
//  Created by Ruslan Ismayilov on 4/28/21.
//

import UIKit
var meme : MemeModel!
class DetailViewController: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!
    var meme : MemeModel!
    override func viewDidLoad() {
        super.viewDidLoad()
         updateView()
    }
    override func viewWillAppear(_ animated: Bool) {
        if let meme = meme {
            detailImage.image = meme.memedImage
        }
    }
    
    func updateView(){
        guard let meme = meme else{return}
        detailImage.image = meme.memedImage
    }
    
}
