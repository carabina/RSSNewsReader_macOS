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
    let shared = RSSXmlParser()
}

// MARK: - Interface
extension RSSXmlParser {
    func parseProvider(data: Data) -> RSSProvider {
        let xml = SWXMLHash.parse(data)
        let provider = RSSProvider()
        
        provider.name = xml["rss"]["channel"]["title"].element?.text
        provider.introduce = xml["rss"]["channel"]["description"].element?.text
        provider.imageURL = xml["rss"]["channel"]["image"]["url"].element?.text
        
        return provider
    }
    
    func parseArticles(data: Data) -> [RSSArticle] {
        let xml = SWXMLHash.parse(data)
        var articles = [RSSArticle]()
        
        xml["rss"]["channel"]["item"].all.forEach { item in
            let article = RSSArticle()
            article.title = item["title"].element?.text
            article.link = item["link"].element?.text
            article.contents = item["description"].element?.text
            
            if let dateString = item["pubDate"].element?.text {
                article.pubDate = dateStringToDate(dateString)
            }
            
            articles.append(article)
        }
        
        return articles
    }
}

// MARK: - Internal
fileprivate extension RSSXmlParser {
    func dateStringToDate(_ dateStr: String) -> Date? {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss +zzzz"
        formatter.locale = Locale(identifier: "US_en")
        
        return formatter.date(from: dateStr)
    }
}
