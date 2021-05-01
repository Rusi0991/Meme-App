//
//  SentMemeTableViewController.swift
//  Meme App
//
//  Created by Ruslan Ismayilov on 4/27/21.
//

import UIKit

class SentMemeTableViewController: UITableViewController {

    
    //Mark : Properties
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
       var memes = [MemeModel]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController

                let meme = self.memes[(indexPath as NSIndexPath).row]
        detailController.detailImage.image = meme.memedImage
    }
    func toDoWhenInView() {
    
        
            memes = appDelegate.memes
            tableView.reloadData()
            self.navigationController?.navigationBar.isHidden = false
            self.tabBarController?.tabBar.isHidden = false
    
        }

    //Goto edit
 
     @IBAction func addMoreButton(_ sender: Any) {
 
         let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
 
         self.navigationController!.pushViewController(detailController, animated: true)
 
     }
    
}
