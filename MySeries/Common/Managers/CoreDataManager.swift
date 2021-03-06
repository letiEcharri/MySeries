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

class CoreDataManager {
    
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
            transc.setValue(0, forKey: "score")
            
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
    
    func save(episode: String, id: Int, serieID: Int, season: Int) {
        let context = getContext()
        
        if !exitsEpisode(id: id) {
            //retrieve the entity
            let entity =  NSEntityDescription.entity(forEntityName: Entity.episode.rawValue, in: context)
            let transc = NSManagedObject(entity: entity!, insertInto: context)
            
            //set the entity values
            transc.setValue(id, forKey: "id")
            transc.setValue(episode, forKey: "name")
            transc.setValue(false, forKey: "watched")
            transc.setValue(serieID, forKey: "serieID")
            transc.setValue(season, forKey: "season")
            
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
    
    func fetchEpisodes() -> [CDEpisode] {
        var episodes: [CDEpisode] = [CDEpisode]()
        
        let fetchRequest = NSFetchRequest<CDEpisode>(entityName: Entity.episode.rawValue)
        
        do {
            let fetchedResults = try getContext().fetch(fetchRequest)
            for item in fetchedResults where (item.id > 0) {
                episodes.append(item)
            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        
        return episodes
    }
    
    func watchEpisode(id: Int, value: Bool) {
        let context = getContext()
        
        let fetchRequest = NSFetchRequest<CDEpisode>(entityName: Entity.episode.rawValue)

        do {
            let fetchedResults = try context.fetch(fetchRequest)
            if fetchedResults.count > 0 {
                for item in fetchedResults where (item.id > 0) {
                    if item.id == id {
                        item.watched = value
                        try context.save()
                        print("Episode watched: \(value)")
                    }
                }
            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
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
                for item in fetchedResults where (item.id > 0){
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
    
    func saveSerie(score: Int, id: Int) {
        let context = getContext()
        
        let fetchRequest = NSFetchRequest<CDSerie>(entityName: Entity.serie.rawValue)
        
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            if fetchedResults.count > 0 {
                for item in fetchedResults where (item.id == id) {
                    item.score = Int32(score)
                    try context.save()
                    print("Serie score saved: \(score)")
                }
            }
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
    }
}
