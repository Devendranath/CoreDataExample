//
//  CoreDataManager.swift
//  CoreDataExample
//
//  Created by apple on 10/01/19.
//  Copyright © 2019 iOSProofs. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private init() { }
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataExample")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    func save () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch() -> [School] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "School")

        do {
            let schools = try context.fetch(fetchRequest) as? [School]
            return schools ?? []
            
        } catch {
            print("Some error occurred during the fetch operation:\(error)")
            return []
        }
    }
    
    func deleteSchool(aSchool: School) {
        context.delete(aSchool)
        save()
    }
    
}
