//
//  RSSProvider.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 14..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class RSSProvider: NSObject, CoreDataInterface {
    var title: String
    var introduce: String
    var image: NSImage?
    var imageURL: String?
    
    static func entity() -> String {
        return "\(CoreProvider.self)"
    }
    
    init(title: String, introduce: String, imageURL: String?) {
        self.title = title
        self.introduce = introduce
        self.imageURL = imageURL
        
        super.init()
        
        loadImage()
    }
    
    required init(managedObject: NSManagedObject) {
        self.title = managedObject.value(forKey: "name") as! String
        self.introduce = managedObject.value(forKey: "introduce") as! String
        self.imageURL = managedObject.value(forKey: "imageURL") as? String
        
        super.init()
        
        loadImage()
    }
}

// MARK: - Internal
fileprivate extension RSSProvider {
    func loadImage() {
        guard let _imageURL = self.imageURL else {
            return
        }
        
        NetworkService.shared.image(url: _imageURL) { [weak self] (image, error) in
            self?.image = image
        }
    }
}
