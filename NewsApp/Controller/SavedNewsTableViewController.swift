//
//  FavouritesTableViewController.swift
//  NewsApp
//
//  Created by iMac on 2022-08-25.
//

import UIKit
import HGPlaceholders
import CoreData

class SavedNewsTableViewController: UITableViewController
{
    var articles: [Article] = []
    var savedArticles = [NewsArticle]()
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //tableView.frame = view.bounds
        
        CoreDataManager.loadData()
        
        if articles.isEmpty
        {
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        CoreDataManager.loadData()
        savedArticles = CoreDataManager.savedArticles
        tableView.reloadData()
    }
    
    @IBAction func deleteAllSavedItems(_ sender: Any)
    {
        let actionSheetController = UIAlertController(title: "Warning!", message: "Do you really want to remove all items?", preferredStyle: .actionSheet)
        actionSheetController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            CoreDataManager.deleteAllData(entity: "NewsArticle")
            CoreDataManager.loadData()
        }))
        
        actionSheetController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
        present(actionSheetController, animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return savedArticles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedNewsTableViewCell", for: indexPath) as? SavedNewsTableViewCell else {return UITableViewCell()}

        //let item = articles[indexPath.row]
        //cell.savedNewsTitleLabel.text = item.title
        //cell.savedNewsImageView.sd_setImage(with: URL(string: item.urlToImage ?? ""))
        
        
        
        let item = savedArticles[indexPath.row]
        cell.savedNewsTitleLabel.text = item.articleAuthor
        //cell.savedNewsImageView.sd_setImage(with: URL(string: item.articleImageURL ?? ""))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        
        let item = articles[indexPath.row]
        vc.item = item
        
        //present(vc, animated: true)
        show(vc, sender: self)
        //navigationController?.pushViewController(vc, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
