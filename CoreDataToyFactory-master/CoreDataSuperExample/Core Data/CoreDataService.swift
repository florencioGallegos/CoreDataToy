//
//  CoreDataService.swift
//  CoreDataSuperExample
//
//  Created by Kevin Yu on 3/5/19.
//  Copyright © 2019 Kevin Yu. All rights reserved.
//

import Foundation
import CoreData

/*
 Core Data Stack
 (top to bottom)
 1. NSManagedObjectContext(m)  - Context
 2. PersistStoreCoordinator(s) - Coordinator(?)
 3. PersistentContainer(s)
 4. NSManagedObjects(m)        - Core Data Items/Entities/Objects
 
 4. Describe the objects in your Core Data stack
    -MUST be created & managed in your Context
 
 3. PersistentContainer == Disk/place where data is saved
 2. Coordinator = manages how you perform saving
 
 1. Context == represents your RAM/memory
    -load data into memory
    -save data into disk
    -create items/update items/delete items
    -undo changes
    -temporary
    -NSManagedObjects MUST be created & managed here
    -not thread safe (we'll go into this later)
 */

/*
 .xcdatamodel - file that describes your NSManagedObjects
 attributes / properties of your objects
 relationships of your objects
 a few other things
 
 */

class CoreDataService {
    
    // MARK: - Core Data stack
    
    // computed property
    /// for main-thread use, only.
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataSuperExample")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func getToy() -> Toy? {
        
        // performing a (NS)FetchRequest from the context
        let fetchRequest = NSFetchRequest<Toy>(entityName: "Toy")
        
        // (optional: ) use NSPredicates to better-define our search
        do {
            let toys = try context.fetch(fetchRequest)
            print("There are \(toys.count) many toys in Core Data")
            return toys.first
        }
        catch {
            print("Error in loading from file")
        }
        return nil
    }
    
    func getGame() -> Game? {
        
        // performing a (NS)FetchRequest from the context
        let fetchRequest = NSFetchRequest<Game>(entityName: "Game")
        
        // (optional: ) use NSPredicates to better-define our search
        do {
            let games = try context.fetch(fetchRequest)
            print("There are \(games.count) many games in Core Data")
            return games.first
        }
        catch {
            print("Error in loading from file")
        }
        return nil
    }
    
    func loadAllToys() -> [Toy] {
        // performing a (NS)FetchRequest from the context
        let fetchRequest = NSFetchRequest<Toy>(entityName: "Toy")
        
        // (optional: ) use NSPredicates to better-define our search
        do {
            let toys = try context.fetch(fetchRequest)
            print("There are \(toys.count) many toys in Core Data")
            return toys
        }
        catch {
            print("Error in loading from file")
        }
        return []
    }
    
    func loadAllGames() -> [Game] {
        // performing a (NS)FetchRequest from the context
        let fetchRequest = NSFetchRequest<Game>(entityName: "Game")
        
        // (optional: ) use NSPredicates to better-define our search
        do {
            let games = try context.fetch(fetchRequest)
            print("There are \(games.count) many games in Core Data")
            return games
        }
        catch {
            print("Error in loading from file")
        }
        return []
    }
    
    func deleteToy(_ toy: Toy) {
        // delete from context
        context.delete(toy)
        // persist changes in context to persistentStore
        saveContext()
    }
    
    func deleteGame(_ game: Game) {
        // delete from context
        context.delete(game)
        // persist changes in context to persistentStore
        saveContext()
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension CoreDataService {
    func findAll(_ name: String) -> [Toy] {
        // performing a (NS)FetchRequest from the context
        let fetchRequest = NSFetchRequest<Toy>(entityName: "Toy")
        
        // (optional: ) use NSPredicates to better-define our search
        // NSPredicates & Queries are very similar
        let predicate = NSPredicate.init(format: "name == %@", name)
        fetchRequest.predicate = predicate
        do {
            let toys = try context.fetch(fetchRequest)
            print("There are \(toys.count) many \(name)'s in Core Data")
            return toys
        }
        catch {
            print("Error in loading from file")
        }
        return []
    }
    
    func findAll(_ name: String) -> [Game] {
        // performing a (NS)FetchRequest from the context
        let fetchRequest = NSFetchRequest<Game>(entityName: "Game")
        
        // (optional: ) use NSPredicates to better-define our search
        // NSPredicates & Queries are very similar
        let predicate = NSPredicate.init(format: "name == %@", name)
        fetchRequest.predicate = predicate
        do {
            let games = try context.fetch(fetchRequest)
            print("There are \(games.count) many \(name)'s in Core Data")
            return games
        }
        catch {
            print("Error in loading from file")
        }
        return []
    }}
