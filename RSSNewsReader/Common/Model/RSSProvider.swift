//
//  RSSProvider.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 14..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class RSSProvider: NSObject {
    var title: String
    var introduce: String
    var imageURL: String?
    var image: NSImage?
    
    init(title: String, introduce: String, imageURL: String?) {
        self.title = title
        self.introduce = introduce
        self.imageURL = imageURL
    }
}

extension RSSProvider: CoreDataInterface {
    static func entity() -> String {
        return "\(CoreProvider.self)"
    }
}
