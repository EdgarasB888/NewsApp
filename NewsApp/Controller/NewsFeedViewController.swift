//
//  ViewController.swift
//  NewsApp
//
//  Created by iMac on 2022-08-24.
//

import UIKit
import SDWebImage

class NewsFeedViewController: UIViewController
{

    var articles: [Article] = []
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        CoreDataManager.managedObjectContext = appDelegate.persistentContainer.viewContext
        
        NetworkManager.fetchData { articles in
            self.articles = articles
            DispatchQueue.main.async
            {
                self.tblView.reloadData()
            }
        }
    }
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {return UITableViewCell()}
        
        let item = articles[indexPath.row]
        cell.newsTitleLabel.text = item.title
        cell.newsImageView.sd_setImage(with: URL(string: item.urlToImage ?? ""))
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        
        let item = articles[indexPath.row]
        vc.item = item
        
        //present(vc, animated: true)
        show(vc, sender: self)
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 180
    }
}

