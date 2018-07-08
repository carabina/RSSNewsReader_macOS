//
//  RSSXmlParser.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 7..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class RSSXmlParser: NSObject {
    
    enum ParseType {
        case provider // RSS Provider 정보만 파싱함.
        case article // RSS Article 만 파싱함.
    }
    
    public static let shared = RSSXmlParser()
    
    fileprivate var type: ParseType!

    func parse(type: ParseType, data: Data) {
        self.type = type
        
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
