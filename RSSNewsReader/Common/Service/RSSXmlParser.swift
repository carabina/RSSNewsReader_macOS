//
//  RSSXmlParser.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 8..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa
import SWXMLHash

class RSSXmlParser: NSObject {
    static let shared = RSSXmlParser()
}

// MARK: - Interface
extension RSSXmlParser {
    
    func parseProvider(data: Data) -> RSSProvider? {
        let xml = SWXMLHash.parse(data)
        
        if let provider = CoreDataService.shared.entity(name: "RSSProvider") {
            provider.setValue(xml["rss"]["channel"]["title"].element?.text, forKey: "name")
            provider.setValue(xml["rss"]["channel"]["description"].element?.text, forKey: "introduce")
            provider.setValue(xml["rss"]["channel"]["image"]["url"].element?.text, forKey: "imageURL")
            
            return provider as? RSSProvider
        }
        
        return nil
    }
    
    func parseArticles(data: Data) -> [RSSArticle] {
        let xml = SWXMLHash.parse(data)
        var articles = [RSSArticle]()
        
        xml["rss"]["channel"]["item"].all.forEach { item in
            if let article = CoreDataService.shared.entity(name: "RSSArticle") {
                article.setValue(item["title"].element?.text, forKey: "title")
                article.setValue(item["link"].element?.text, forKey: "link")
                article.setValue(item["description"].element?.text, forKey: "contents")
                
                if let dateString = item["pubDate"].element?.text {
                    article.setValue(stringToDate(dateString), forKey: "pubDate")
                }
                
                articles.append(article as! RSSArticle)
            }
        }
        
        return articles
    }
}

// MARK: - Internal
fileprivate extension RSSXmlParser {
    func stringToDate(_ dateStr: String) -> Date? {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss +zzzz"
        formatter.locale = Locale(identifier: "US_en")
        
        return formatter.date(from: dateStr)
    }
}
