//
//  RSSProvider.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 7..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class RSSProvider: NSObject {
    var name: String!
    var image: NSImage!
    
    init(name: String, imageURL: String) {
        self.name = name
    }
}
