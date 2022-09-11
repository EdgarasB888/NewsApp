//
//  DetailViewController.swift
//  NewsApp
//
//  Created by iMac on 2022-08-24.
//

import UIKit
import CoreData

class DetailViewController: UIViewController
{
    var item: Article?
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var titleText: String? = ""
    var titleLabelText: String? = ""
    var descriptionLabelText: String? = ""
    var articleImageUrl: String? = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        CoreDataManager.managedObjectContext = appDelegate.persistentContainer.viewContext
    
        self.title = titleText
        titleLabel.text = titleLabelText
        descriptionLabel.text = descriptionLabelText
        
        newsImageView.sd_setImage(with: URL(string: articleImageUrl ?? ""))
    }
    
    @IBAction func shareButtonTapped(_ sender: Any)
    {
        presentShareSheet()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any)
    {
        basicAlertSheet(title: "Attention!", message: "Article successfully added to saved list!")
        
        let newItem = NewsArticle(context: CoreDataManager.managedObjectContext!)
        newItem.articleAuthor = titleText
        newItem.articleTitle = titleLabelText
        newItem.articleImageURL = articleImageUrl
        newItem.articleDescription = descriptionLabelText
        CoreDataManager.savedArticles.append(newItem)
        
        /*
        if let entity = NSEntityDescription.entity(forEntityName: "NewsArticle", in: CoreDataManager.managedObjectContext!)
        {
            let news = NSManagedObject(entity: entity, insertInto: CoreDataManager.managedObjectContext)
            news.setValue(item?.title, forKey: "articleAuthor")
            news.setValue(item?.url, forKey: "articleImageURL")
            news.setValue(item?.articleDescription, forKey: "articleDescription")
        }
         */
        
        CoreDataManager.saveData()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard let dVC: WebViewController = segue.destination as? WebViewController else {return}
        
        dVC.urlString = item?.url ?? ""
    }
}

extension DetailViewController
{
    private func presentShareSheet()
    {
        let shareSheetVC = UIActivityViewController(activityItems: [item?.author ?? ""], applicationActivities: nil)
        
        present(shareSheetVC, animated: true)
    }
    
    private func basicAlertSheet(title: String?, message: String?)
    {
        DispatchQueue.main.async
        {
            let alertSheet: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let dismissAction: UIAlertAction = UIAlertAction(title: "Dismiss", style: .default)
            
            alertSheet.addAction(dismissAction)
            self.present(alertSheet, animated: true)
        }
    }
}
