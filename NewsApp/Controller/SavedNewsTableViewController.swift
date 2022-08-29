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
    var savedArticles = [NewsArticle]()
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //tableView.frame = view.bounds
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        CoreDataManager.managedObjectContext = appDelegate.persistentContainer.viewContext
        
        CoreDataManager.loadData()
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
            //CoreDataManager.loadData()
            CoreDataManager.saveData()
            self.savedArticles = CoreDataManager.savedArticles
            self.tableView.reloadData()
        }))
        
        /*
        DispatchQueue.main.async
        {
            self.tableView.reloadData()
        }
         */
        
        actionSheetController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
        present(actionSheetController, animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //return savedArticles.count
        
        if savedArticles.count > 0
        {

            return savedArticles.count
        }
        else
        {
            let customPlaceholder = CustomPlaceholderView()
            tableView.backgroundView = customPlaceholder

            customPlaceholder.safetyAreaTopAnchor = tableView.safeAreaLayoutGuide.topAnchor
            customPlaceholder.safetyAreaBottomAnchor = tableView.safeAreaLayoutGuide.bottomAnchor
            customPlaceholder.safetyLeadingAnchor = tableView.safeAreaLayoutGuide.leadingAnchor
            customPlaceholder.safetyTrailingAnchor = tableView.safeAreaLayoutGuide.trailingAnchor

            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if savedArticles.count != 0
        {
            tableView.backgroundView?.isHidden = true
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SavedNewsTableViewCell", for: indexPath) as? SavedNewsTableViewCell else {return UITableViewCell()}
        
        let item = savedArticles[indexPath.row]
        cell.savedNewsTitleLabel.text = item.articleAuthor
        cell.savedNewsImageView.sd_setImage(with: URL(string: item.articleImageURL ?? ""))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        
        let item = savedArticles[indexPath.row]
        vc.titleText = item.articleAuthor
        vc.titleLabelText = item.articleTitle
        vc.titleLabelText = item.articleDescription
        vc.articleImageUrl = item.articleImageURL
        
        //present(vc, animated: true)
        show(vc, sender: self)
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
                let item = CoreDataManager.savedArticles[indexPath.row]
                CoreDataManager.managedObjectContext?.delete(item)
                CoreDataManager.saveData()
                self.savedArticles = CoreDataManager.savedArticles
                tableView.reloadData()
            }))
            
            self.present(alert, animated: true)
        }
    }
}
