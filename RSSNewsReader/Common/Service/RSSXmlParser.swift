//
//  RSSXmlParser.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 8..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class RSSXmlParser: XMLParser {
    class func parseProvider(data: Data, onCompletion: @escaping (_ provider: RSSProvider?) -> ()) {
        
    }
    
    class func parseArticles(data: Data, onCompletion: @escaping (_ articles: [RSSArticle]?) -> ()) {
        
    }
}

extension RSSXmlParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
}
