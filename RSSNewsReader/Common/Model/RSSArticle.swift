//
//  RSSArticle.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 14..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class RSSArticle: NSObject {
    var title: String
    var link: String
    var contents: String
    var pubDate: Date
    
    init(title: String, link: String, contents: String, pubDate: Date) {
        self.title = title
        self.link = link
        self.contents = contents
        self.pubDate = pubDate
    }
}

extension RSSArticle: CoreDataInterface {
    static func entity() -> String {
        return "\(CoreArticle.self)"
    }
}
