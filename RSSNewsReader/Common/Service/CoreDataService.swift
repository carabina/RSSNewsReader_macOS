//
//  CoreDataService.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 11..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

enum CoreDataError: Error {
    case managedContextNotExist
    case entityNameNotCorrect
    case saveFailed(reason: String)
}

extension CoreDataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .managedContextNotExist:
            return NSLocalizedString("managed context is nil", comment: "")
        case .entityNameNotCorrect:
            return NSLocalizedString("entity name is no correct", comment: "")
        case .saveFailed(reason: let reason):
            return NSLocalizedString(reason, comment: "")
        }
    }
}

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
    
    func save(_ provider: RSSProvider) -> Error? {
        guard let managedContext = self.managedContext else {
            return CoreDataError.managedContextNotExist
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: RSSProvider.entity(), in: managedContext) else {
            return CoreDataError.entityNameNotCorrect
        }
        
        let coreProvider = NSManagedObject(entity: entity, insertInto: managedContext)
        
        coreProvider.setValue(provider.title, forKey: "name")
        coreProvider.setValue(provider.introduce, forKey: "introduce")
        coreProvider.setValue(provider.imageURL, forKey: "imageURL")
        
        do {
            try managedContext.save()
            return nil
        } catch let error as NSError {
            return CoreDataError.saveFailed(reason: error.localizedDescription)
        }
    }
}

// MARK: - Internal
fileprivate extension CoreDataService {
    
}
