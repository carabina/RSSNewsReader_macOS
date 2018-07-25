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
    static let shared = CoreDataManager()
    
    var appDelegate: AppDelegate? {
        return NSApplication.shared.delegate as? AppDelegate
    }
    
    var managedContext: NSManagedObjectContext? {
        return appDelegate?.persistentContainer.viewContext
    }
}

// MARK: - Interface - Save
extension CoreDataManager {
    
    func save(provider: RSSProvider) -> Error? {
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
    
    func save(providerName: String, articles: [RSSArticle]) -> Error? {
        guard let managedContext = self.managedContext else {
            return CoreDataError.managedContextNotExist
        }

        guard let entity = NSEntityDescription.entity(forEntityName: RSSArticle.entity(), in: managedContext) else {
            return CoreDataError.entityNameNotCorrect
        }
        
        let tuple = self.provider(name: providerName)

        // Article이 소속될 Provider를 가져옴.
        guard let coreProvider = tuple.coreProvider else {
            if let error = tuple.error {
                return CoreDataError.fetchFailed(reason: error.localizedDescription)
            } else {
                return CoreDataError.fetchFailed(reason: "웹사이트 이름이 정확하지 않습니다.")
            }
        }
        
        articles.forEach { article in
            let coreArticle = CoreArticle(entity: entity, insertInto: managedContext)
            
            coreArticle.setValue(article.providerName, forKey: "providerName")
            coreArticle.setValue(article.title, forKey: "title")
            coreArticle.setValue(article.link, forKey: "link")
            coreArticle.setValue(article.contents, forKey: "contents")
            coreArticle.setValue(article.pubDate, forKey: "pubDate")
            
            coreProvider.addToArticle(coreArticle)
        }
        
        return nil
    }
}

// MARK: - Interface - Fetch
extension CoreDataManager {
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
    
    func fetchArticles() -> (articles: [RSSArticle]?, error: Error?) {
        guard let managedContext = self.managedContext else {
            return (nil, CoreDataError.managedContextNotExist)
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: RSSArticle.entity())
        
        do {
            let objectArray = try managedContext.fetch(fetchRequest)
            var articleArray = [RSSArticle]()
            
            objectArray.forEach { managedObject in
                articleArray.append(RSSArticle(managedObject: managedObject))
            }
            
            return (articleArray, nil)
        } catch let error as NSError {
            return (nil, CoreDataError.fetchFailed(reason: error.localizedDescription))
        }
    }
}

// MARK: - Interface - Delete
extension CoreDataManager {
    func removeAllProviders() -> Error? {
        guard let managedContext = self.managedContext else {
            return CoreDataError.managedContextNotExist
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: RSSProvider.entity())
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
            
            return nil
        } catch let error as NSError {
            return error
        }
    }
}

// MARK: - Internal - Getting CoreModel
fileprivate extension CoreDataManager {
    func provider(name: String) -> (coreProvider: CoreProvider?, error: Error?) {
        guard let managedContext = self.managedContext else {
            return (nil, CoreDataError.managedContextNotExist)
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: RSSProvider.entity())
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            return (try managedContext.fetch(fetchRequest).first as? CoreProvider, nil)
        } catch let error as NSError {
            return (nil, CoreDataError.fetchFailed(reason: error.localizedDescription))
        }
    }
}
