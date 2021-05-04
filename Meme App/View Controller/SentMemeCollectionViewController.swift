//
//  SentMemeCollectionViewController.swift
//  Meme App
//
//  Created by Ruslan Ismayilov on 4/27/21.
//

import UIKit



class SentMemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    //Mark : Properties
    
    
    var memes: [MemeModel]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
//    Mark : Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        tabBarController?.tabBar.isHidden = false
        
        let space:CGFloat = 3.0
            let dimension = (view.frame.size.width - (2 * space)) / 3.0

            flowLayout.minimumInteritemSpacing = space
            flowLayout.minimumLineSpacing = space
            flowLayout.itemSize = CGSize(width: dimension, height: dimension)

            
        
    }
           override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
   
            collectionView!.reloadData()
            tabBarController?.tabBar.isHidden = false
       }
   
         
           
           
    
        
    
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
         // Configure cell
        cell.imageView.image = meme.memedImage
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

                let meme = self.memes[(indexPath as NSIndexPath).row]
        detailController.detailImage.image = meme.memedImage

        navigationController?.pushViewController(detailController, animated: true)
}
}
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "DetailVC" {
//            if let vc = segue.destination as? DetailViewController,
//
//               let indexPath = collectionView.indexPathsForSelectedItems?.first{
//                let detailMeme = memes[indexPath.row]
//                vc.detailImage.image = detailMeme.memedImage
//            }
//            }
//        }
//    }
   
    

    

     
                    

                    
                    
                
               
               
            
            
        
    

    

    

   
    



