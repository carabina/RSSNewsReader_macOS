//
//  RSSArticle.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 14..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class RSSArticle: NSObject, CoreDataInterface {
    var providerName: String
    
    var title: String
    var link: String
    var contents: String
    var pubDate: Date
    
    static func entity() -> String {
        return "\(CoreArticle.self)"
    }
    
    init(providerName: String, title: String, link: String, contents: String, pubDate: Date) {
        self.providerName = providerName
        self.title = title
        self.link = link
        self.contents = contents
        self.pubDate = pubDate
    }
    
    required init(managedObject: NSManagedObject) {
        self.providerName = managedObject.value(forKey: "providerName") as! String
        self.title = managedObject.value(forKey: "title") as! String
        self.link = managedObject.value(forKey: "link") as! String
        self.contents = managedObject.value(forKey: "contents") as! String
        self.pubDate = managedObject.value(forKey: "pubDate") as! Date
    }
}
