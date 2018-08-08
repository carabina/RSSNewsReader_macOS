//
//  RSSXmlParser.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 8..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa
import SWXMLHash

// TODO: Error 처리 해야함.

/// XML RSS를 파싱하는 클래스.
class RSSXmlParser: NSObject { }

// MARK: - Interface
extension RSSXmlParser {
    
    class func parseProvider(linkURL: String, data: Data) -> RSSProvider? {
        let xml = SWXMLHash.parse(data)
        
        guard let title = xml["rss"]["channel"]["title"].element?.text else {
            return nil
        }
        
        guard let introduce = xml["rss"]["channel"]["description"].element?.text else {
            return nil
        }
        
        let imageURL = xml["rss"]["channel"]["image"]["url"].element?.text
        
        return RSSProvider(title: title, introduce: introduce, link: linkURL, imageURL: imageURL)
    }
    
    class func parseArticles(data: Data) -> [RSSArticle]? {
        let xml = SWXMLHash.parse(data)
        var articles = [RSSArticle]()
        
        guard let providerName = xml["rss"]["channel"]["title"].element?.text else {
            return nil
        }
        
        for i in 0 ..< xml["rss"]["channel"]["item"].all.count {
            let item = xml["rss"]["channel"]["item"][i]
            
            guard let title = item["title"].element?.text else {
                continue
            }
            
            guard let link = item["link"].element?.text else {
                continue
            }
            
            guard let desc = item["description"].element?.text else {
                continue
            }
            
            guard let dateString = item["pubDate"].element?.text else {
                continue
            }
            
            
            
            articles.append(RSSArticle(providerName: providerName, title: title, link: link, desc: desc, pubDate: stringToDate(dateString)!))
        }

        return articles
    }
}

// MARK: - Internal
fileprivate extension RSSXmlParser {
    class func stringToDate(_ dateStr: String) -> Date? {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss +zzzz" // TODO: Endgadget에서 맨 마지막 부분을 "-0400" 형태로 떨어뜨려 줌.
        formatter.locale = Locale(identifier: "US_en")
        
        return formatter.date(from: dateStr)
    }
}
