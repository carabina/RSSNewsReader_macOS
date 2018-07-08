//
//  RSSArticle.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 8..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class RSSArticle: NSObject {
    var title: String!
    var link: String!
    var pubDate: Date!
    var image: NSImage!
    var contents: String!
    
    fileprivate var imageURL: String! {
        didSet {
            
        }
    }
}
