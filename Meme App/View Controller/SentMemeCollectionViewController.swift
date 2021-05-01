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
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
       var memes = [MemeModel]()
    
//    Mark : Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let space:CGFloat = 3.0
            let dimension = (view.frame.size.width - (2 * space)) / 3.0

            flowLayout.minimumInteritemSpacing = space
            flowLayout.minimumLineSpacing = space
            flowLayout.itemSize = CGSize(width: dimension, height: dimension)

            toDoWhenInView()
        
    }
           override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
   
           toDoWhenInView()
   
       }
   
           override func viewDidAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
   
           toDoWhenInView()
   
       }
           
           override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    
            super .viewWillTransition(to: size, with: coordinator)
    
            collectionView.reloadData()
    
            toDoWhenInView()
    
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
    }
    func toDoWhenInView() {
   
    memes = appDelegate.memes
    collectionView.reloadData()
    self.navigationController?.navigationBar.isHidden = false
    self.tabBarController?.tabBar.isHidden = false
    
        }
    
    @IBAction func addMoreButton(_ sender: Any) {

        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

        self.navigationController!.pushViewController(detailController, animated: true)
    
}
     
                    
}
                    
                    
                
               
               
            
            
        
    

    

    

   
    



