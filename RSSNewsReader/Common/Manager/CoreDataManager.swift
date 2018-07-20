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
    case fetchFailed(reason: String)
    case alreadyExist
}

extension CoreDataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .managedContextNotExist:
            return NSLocalizedString("managed context 가 존재하지 않습니다.", comment: "")
        case .entityNameNotCorrect:
            return NSLocalizedString("entity name 이 올바르지 않습니다.", comment: "")
        case .saveFailed(reason: let reason):
            return NSLocalizedString(reason, comment: "")
        case .fetchFailed(reason: let reason):
            return NSLocalizedString(reason, comment: "")
        case .alreadyExist:
            return NSLocalizedString("이미 추가된 웹사이트입니다.", comment: "")
        }
    }
}

class CoreDataManager: NSObject {
    // Singleton
    static let shared = CoreDataManager()
    
    var appDelegate: AppDelegate? {
        return NSApplication.shared.delegate as? AppDelegate
    }
    
    var managedContext: NSManagedObjectContext? {
        return appDelegate?.persistentContainer.viewContext
    }
}

// MARK: - Interface
extension CoreDataManager {
    
    func save(provider: RSSProvider) -> Error? { // TODO: 중복저장 안되도록 수정해야 함.
        guard let managedContext = self.managedContext else {
            return CoreDataError.managedContextNotExist
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: RSSProvider.entity(), in: managedContext) else {
            return CoreDataError.entityNameNotCorrect
        }
        
        // 중복 데이터가 저장되었는지 확인
        if let savedProviders = fetchProvider().provider {
            if !(savedProviders.filter { $0.title == provider.title }.isEmpty) {
                return CoreDataError.alreadyExist
            }
        }
        
        let coreProvider = NSManagedObject(entity: entity, insertInto: managedContext)
        
        coreProvider.setValue(provider.title, forKey: "name")
        coreProvider.setValue(provider.introduce, forKey: "introduce")
        coreProvider.setValue(provider.imageURL, forKey: "imageURL")
        
        do {
            try managedContext.save()
            return nil
        } catch let error as NSError {
            // TODO: raw error가 사용자에게 그대로 노출됨.
            return CoreDataError.saveFailed(reason: error.localizedDescription)
        }
    }
    
    func fetchProvider() -> (provider: [RSSProvider]?, error: Error?) {
        guard let managedContext = self.managedContext else {
            return (nil, CoreDataError.managedContextNotExist)
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: RSSProvider.entity())
        
        do {
            let objectArray = try managedContext.fetch(fetchRequest)
            var providerArray = [RSSProvider]()
            
            objectArray.forEach { managedObject in
                providerArray.append(RSSProvider(managedObject: managedObject))
            }
            
            return (providerArray, nil)
        } catch let error as NSError {
            return (nil, CoreDataError.fetchFailed(reason: error.localizedDescription))
        }
    }
}

// MARK: - Internal
fileprivate extension CoreDataManager {
    
}
