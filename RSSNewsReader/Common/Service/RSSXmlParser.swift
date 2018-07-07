//
//  RSSXmlParser.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 7..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class RSSXmlParser: NSObject {
    
    public static let shared = RSSXmlParser()

    func parse(data: Data) {
        let xmlParser = XMLParser(data: data)
        xmlParser.delegate = self
        xmlParser.parse()
    }
}

extension RSSXmlParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print(elementName)
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print(elementName)
    }
}
