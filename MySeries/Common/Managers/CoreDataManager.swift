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
    func save(serie: Serie)
    func fetchSeries() -> [CDSerie]
}

class CoreDataManager: CoreDataProtocol {
    
    let serieEntity: String = "CDSerie"
    
    func save(serie: Serie) {
        let context = getContext()

        //retrieve the entity
        let entity =  NSEntityDescription.entity(forEntityName: serieEntity, in: context)
        let transc = NSManagedObject(entity: entity!, insertInto: context)

        //set the entity values
        transc.setValue(serie.id, forKey: "id")
        transc.setValue(serie.name, forKey: "name")
        
        //save the object
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
    }
    
    func fetchSeries() -> [CDSerie] {
        var series: [CDSerie] = [CDSerie]()
        
        let fetchRequest = NSFetchRequest<CDSerie>(entityName: serieEntity)
        
        do {
            let fetchedResults = try getContext().fetch(fetchRequest)
            series = fetchedResults
        } catch let error as NSError {
            // something went wrong, print the error.
            print(error.description)
        }
        
        return series
    }
    
    private func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
