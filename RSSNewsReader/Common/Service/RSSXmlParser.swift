//
//  RSSXmlParser.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 8..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class RSSXmlParser: XMLParser {
    fileprivate var childOfChannel = false
    fileprivate var childOfImage = false
    fileprivate var childOfItem = false
    
    fileprivate lazy var provider = RSSProvider()
    fileprivate lazy var articles = [RSSArticle]()
    
    typealias CompletionHandler = (_ provider: RSSProvider?, _ articles: [RSSArticle]?) -> ()
    
    var type: ParseType!
    var completionHandler: CompletionHandler?
    
    enum ParseType {
        case provider // Feed 제공자의 정보만 파싱함.
        case article // 기사만 파싱함.
    }
    
    // MARK: - Interface
    func parse(type: ParseType, onCompletion: CompletionHandler?) {
        self.type = type
        self.completionHandler = onCompletion
        self.delegate = self
        
        parse()
    }
}

// MARK: - XMLParserDelegate
extension RSSXmlParser: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        childOfChannel = (elementName == "channel")
        childOfImage = (elementName == "image")
        childOfItem = (elementName == "item")
        
        if childOfChannel && elementName == "title" {
            provider.name = elementName
        } else if childOfImage && elementName == "url" {
            provider.imageURL = elementName
        } else if childOfItem {
            if elementName == "title" {
                articles.append(RSSArticle())
                articles.last!.title = elementName
            } else if elementName == "link" {
                articles.last!.link = elementName
            } else if elementName == "pubDate" {
                articles.last!.pubDate = elementName
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        childOfChannel = (elementName == "channel")
        childOfImage = (elementName == "image")
        childOfItem = (elementName == "item")
        
        if type == .provider && childOfItem {
            abortParsing()
            completionHandler?(provider, nil)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        completionHandler?(provider, articles)
    }
}
