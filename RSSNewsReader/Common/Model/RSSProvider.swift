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
    var link: String
    var imageURL: String?
    
    static func entity() -> String {
        return "\(CoreProvider.self)"
    }
    
    init(title: String, introduce: String, link: String, imageURL: String?) {
        self.title = title
        self.introduce = introduce
        self.link = link
        self.imageURL = imageURL
    }
    
    required init(managedObject: NSManagedObject) {
        self.title = managedObject.value(forKey: "name") as! String
        self.introduce = managedObject.value(forKey: "introduce") as! String
        self.link = managedObject.value(forKey: "link") as! String
        self.imageURL = managedObject.value(forKey: "imageURL") as? String
    }
}
