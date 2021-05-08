//
//  SentMemeTableViewController.swift
//  Meme App
//
//  Created by Ruslan Ismayilov on 4/27/21.
//

import UIKit

class SentMemeTableViewController: UITableViewController {

    var meme : MemeModel!
    //Mark : Properties
    var memes: [MemeModel]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = false
        }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

        tableView.reloadData()
        tabBarController?.tabBar.isHidden = false
}

    

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! MemeTableViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Configure cell
        
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topText + "..." + meme.bottomText
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailController.meme = memes[indexPath.row]
        navigationController!.pushViewController(detailController, animated: true)
    }
    
    
      }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "DetailVC", sender: indexPath)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "DetailVC" {
//            if let vc = segue.destination as? DetailViewController,
//
//               let indexPath = tableView.indexPathForSelectedRow{
//                let detailMeme = memes[indexPath.row]
//                vc.meme = detailMeme
//            }
//            }
//        }
//    }

    
 
    

