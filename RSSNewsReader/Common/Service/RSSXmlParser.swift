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
        
        guard let title = xml["rss"]["channel"]["title"].element?.text else {
            return nil
        }
        
        guard let introduce = xml["rss"]["channel"]["description"].element?.text else {
            return nil
        }
        
        let imageURL = xml["rss"]["channel"]["image"]["url"].element?.text
        
        return RSSProvider(title: title, introduce: introduce, imageURL: imageURL)
    }
    
    func parseArticles(data: Data) -> [RSSArticle] {
        let xml = SWXMLHash.parse(data)
        var articles = [RSSArticle]()
        
        for i in 0 ..< xml["rss"]["channel"]["item"].all.count {
            let item = xml["rss"]["channel"]["item"][i]
            
            guard let title = item["title"].element?.text else {
                continue
            }
            
            guard let link = item["link"].element?.text else {
                continue
            }
            
            guard let contents = item["description"].element?.text else {
                continue
            }
            
            guard let dateString = item["pubDate"].element?.text else {
                continue
            }
            
            articles.append(RSSArticle(title: title, link: link, contents: contents, pubDate: stringToDate(dateString)!))
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
