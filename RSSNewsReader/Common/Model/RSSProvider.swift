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
    var image: NSImage?
    
    var parser: XMLParser?
    
    fileprivate var imageURL: String! {
        didSet {
            parser?.abortParsing()
            NetworkService.image(url: imageURL) { [weak self] (image, error) in
                if (error == nil) {
                    self?.image = image
                }
            }
        }
    }
    
    init(data: Data) {
        super.init()
        
        parser = XMLParser(data: data)
        parser?.delegate = self
        parser?.parse()
    }
}

extension RSSProvider: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "title" {
            self.name = elementName
        } else if elementName == "url" {
            self.imageURL = elementName
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
}
