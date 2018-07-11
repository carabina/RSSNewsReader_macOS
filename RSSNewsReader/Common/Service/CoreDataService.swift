//
//  CoreDataService.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 11..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class CoreDataService: NSObject {
    // Singleton
    static let shared = CoreDataService()
    
    var appDelegate: AppDelegate? {
        return NSApplication.shared.delegate as? AppDelegate
    }
    
    var managedContext:NSManagedObjectContext? {
        return appDelegate?.persistentContainer.viewContext
    }
}

// MARK: - Interface
extension CoreDataService {
    func save(entityName: String, attr: String, value: Any) -> Bool {
        guard let managedContext = self.managedContext else {
            return false
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else {
            return false
        }
        
        let entityObj = NSManagedObject(entity: entity, insertInto: managedContext)
        
        entityObj.setValue(value, forKey: attr)
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            NSLog("Could not save CoreData: %@", error.localizedDescription)
            return false
        }
    }
    
    func save(entityName: String, attrValueDict: [String: Any]) -> Bool {
        guard let managedContext = self.managedContext else {
            NSLog("NSManagedObjectContext is nil")
            return false
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else {
            NSLog("Cannot access to entity. Check your entity name")
            return false
        }
        
        let entityObj = NSManagedObject(entity: entity, insertInto: managedContext)
        
        attrValueDict.forEach { tuple in
            entityObj.setValue(tuple.value, forKey: tuple.key)
        }
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            NSLog("Could not save CoreData: %@", error.localizedDescription)
            return false
        }
    }
}

// MARK: - Internal
fileprivate extension CoreDataService {
    
}
