//
//  CoreDataManager.swift
//  MySeries
//
//  Created by Leticia Echarri Perez on 8/3/19.
//  Copyright © 2019 Leticia. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataProtocol {
    func save(serie: String, id: Int)
    func save(episode: String, id: Int)
    func fetchSeries() -> [CDSerie]
    func deleteAllRecords(entity: CoreDataManager.Entity)
    func fetchSerie(id: Int) -> CDSerie
    func deleteSerie(id: Int)
    func watchEpisode(id: Int, value: Bool)
    func fetchEpisode(id: Int) -> CDEpisode
    func exitsSerie(id: Int) -> Bool
    func exitsEpisode(id: Int) -> Bool
}

class CoreDataManager: CoreDataProtocol {
    
    enum Entity: String {
        case serie = "CDSerie"
        case episode = "CDEpisode"
    }
    
    private func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func save(serie: String, id: Int) {
        let context = getContext()
        
        if !exitsSerie(id: id) {
            //retrieve the entity
            let entity =  NSEntityDescription.entity(forEntityName: Entity.serie.rawValue, in: context)
            let transc = NSManagedObject(entity: entity!, insertInto: context)
            
            //set the entity values
            transc.setValue(id, forKey: "id")
            transc.setValue(serie, forKey: "name")
            
            //save the object
            do {
                try context.save()
                print("Serie saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
        }
    }
    
    func fetchSeries() -> [CDSerie] {
        var series: [CDSerie] = [CDSerie]()
        
        let fetchRequest = NSFetchRequest<CDSerie>(entityName: Entity.serie.rawValue)
        
        do {
            let fetchedResults = try getContext().fetch(fetchRequest)
            series = fetchedResults
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        
        return series
    }
    
    func deleteAllRecords(entity: Entity) {
        let context = getContext()
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        
        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            for item in items {
                context.delete(item)
            }
            
            // Save Changes
            try context.save()
            print("All records removed!")
            
        } catch {
            print ("There was an error")
        }
        
        
        
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//
//        do {
//            try context.execute(deleteRequest)
//            try context.save()
//            print("All records removed!")
//        } catch {
//            print ("There was an error")
//        }
    }
    
    func fetchSerie(id: Int) -> CDSerie {
        var serie = CDSerie(context: getContext())
        
        let fetchRequest = NSFetchRequest<CDSerie>(entityName: Entity.serie.rawValue)
        
        do {
            let fetchedResults = try getContext().fetch(fetchRequest)
            if fetchedResults.count > 0 {
                for item in fetchedResults {
                    if item.id == id{
                        serie = item
                    }
                }
                
            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        
        return serie
    }
    
    func deleteSerie(id: Int) {
        let fetchRequest = NSFetchRequest<CDSerie>(entityName: Entity.serie.rawValue)
        
        do {
            let fetchedResults = try getContext().fetch(fetchRequest)
            if fetchedResults.count > 0 {
                for item in fetchedResults {
                    if item.id == id{
                        getContext().delete(item)
                    }
                }
                
            }
            
            do {
                try getContext().save()
                print("Record removed!")
            } catch {
                print ("There was an error")
            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
    }
    
    func save(episode: String, id: Int) {
        let context = getContext()
        
        if !exitsEpisode(id: id) {
            
            //retrieve the entity
            let entity =  NSEntityDescription.entity(forEntityName: Entity.episode.rawValue, in: context)
            let transc = NSManagedObject(entity: entity!, insertInto: context)
            
            //set the entity values
            transc.setValue(id, forKey: "id")
            transc.setValue(episode, forKey: "name")
            transc.setValue(false, forKey: "watched")
            
            //save the object
            do {
                try context.save()
                print("Episode saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
        }
    }
    
    func watchEpisode(id: Int, value: Bool) {
        let fetchRequest = NSFetchRequest<CDEpisode>(entityName: Entity.episode.rawValue)
        
        do {
            let fetchedResults = try getContext().fetch(fetchRequest)
            if fetchedResults.count > 0 {
                for item in fetchedResults{
                    if item.id == id {
                        item.setValue(value, forKey: "watched")
                    }
                }
                
            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
    }
    
    func fetchEpisode(id: Int) -> CDEpisode {
        var episode = CDEpisode(context: getContext())
        
        let fetchRequest = NSFetchRequest<CDEpisode>(entityName: Entity.episode.rawValue)
        
        do {
            let fetchedResults = try getContext().fetch(fetchRequest)
            if fetchedResults.count > 0 {
                for item in fetchedResults {
                    if item.id == id{
                        episode = item
                    }
                }
                
            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        
        return episode
    }
    
    func exitsSerie(id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<CDSerie>(entityName: Entity.serie.rawValue)
        
        do {
            let fetchedResults = try getContext().fetch(fetchRequest)
            if fetchedResults.count > 0 {
                for item in fetchedResults {
                    if item.id == id{
                        return true
                    }
                }
                
            }
            return false
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
            return false
        }
    }
    
    func exitsEpisode(id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<CDEpisode>(entityName: Entity.episode.rawValue)
        
        do {
            let fetchedResults = try getContext().fetch(fetchRequest)
            if fetchedResults.count > 0 {
                for item in fetchedResults {
                    if item.id == id{
                        return true
                    }
                }
                
            }
            return false
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
            return false
        }
    }
}
