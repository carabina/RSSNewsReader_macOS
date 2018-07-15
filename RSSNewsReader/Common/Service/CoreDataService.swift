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
    
    var managedContext: NSManagedObjectContext? {
        return appDelegate?.persistentContainer.viewContext
    }
}

// MARK: - Interface
extension CoreDataService {
    
    func save(provider: RSSProvider) -> Bool {
        guard let managedContext = self.managedContext else {
            return false
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: RSSProvider.entity(), in: managedContext) else {
            return false
        }
        
        let coreProvider = NSManagedObject(entity: entity, insertInto: managedContext)
        
        coreProvider.setValue(provider.title, forKey: "name")
        coreProvider.setValue(provider.introduce, forKey: "introduce")
        coreProvider.setValue(provider.imageURL, forKey: "imageURL")
        
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
