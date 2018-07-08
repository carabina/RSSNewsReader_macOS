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
    
    class func parseProvider(data: Data) -> RSSProvider {
        let xml = SWXMLHash.parse(data)
        let provider = RSSProvider()
        
        provider.name = xml["rss"]["channel"]["title"].element?.text
        provider.introduce = xml["rss"]["channel"]["description"].element?.text
        provider.imageURL = xml["rss"]["channel"]["image"]["url"].element?.text
        
        return provider
    }
    
    class func parseArticles(data: Data) -> [RSSArticle] {
        let xml = SWXMLHash.parse(data)
        var articles = [RSSArticle]()
        
        xml["rss"]["channel"]["item"].all.forEach { item in
            let article = RSSArticle()
            article.title = item["title"].element?.text
            article.link = item["link"].element?.text
            article.pubDate = item["pubDate"].element?.text
            article.contents = item["description"].element?.text
            
            articles.append(article)
        }
        
        return articles
    }
}
