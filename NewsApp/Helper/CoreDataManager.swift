//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by iMac on 2022-08-26.
//

import Foundation
import CoreData

class CoreDataManager
{
    static var savedArticles = [NewsArticle]()
    static var managedObjectContext: NSManagedObjectContext?
        
    static func loadData()
    {
        let request: NSFetchRequest<NewsArticle> = NewsArticle.fetchRequest()
        do
        {
            request.sortDescriptors = [NSSortDescriptor(key: "rowOrder", ascending: true)]
            
            if let result = try managedObjectContext?.fetch(request)
            {
                savedArticles = result
                //tableView.reloadData()
            }
        }
        catch
        {
            print("Error in saving core data items!")
        }
    }
    
    static func saveData()
    {
        do
        {
            try managedObjectContext?.save()
        }
        catch
        {
            print("Error in loading core data items!")
        }
        loadData()
    }
    
    static func deleteAllData(entity: String)
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
            
        do
        {
            let results = try managedObjectContext?.fetch(fetchRequest)
            for object in results ?? []
            {
                guard let objectData = object as? NSManagedObject else {continue}
                //dataController.viewContext.delete(objectData)
                //tableView.viewContext.delete()
                managedObjectContext?.delete(objectData)
            }
        }
        catch let error
        {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    
}
