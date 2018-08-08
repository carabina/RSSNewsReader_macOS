//
//  RSSXmlParser.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 8..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa
import SWXMLHash
import SwiftSoup

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
            
            let article = RSSArticle(providerName: providerName, title: title, link: link, desc: desc, pubDate: stringToDate(dateString)!)
            article.thumbnailURL = thumbnailURL(rawHTML: desc)
            
            articles.append(article)
        }

        return articles
    }
}

// MARK: - Internal
fileprivate extension RSSXmlParser {
    class func stringToDate(_ dateStr: String) -> Date? {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzzz"
        formatter.locale = Locale(identifier: "US_en")
        
        return formatter.date(from: dateStr)
    }
    
    /// description 태그의 가장 첫 번째 img를 thumbnail로 판단하여 image url을 가져오도록 함.
    class func thumbnailURL(rawHTML: String) -> String? {
        do {
            let doc = try SwiftSoup.parse(rawHTML)
            if let img = try doc.select("img").first() {
                return try img.attr("src")
            }
        } catch Exception.Error(let type, let message) {
            print(type)
            print(message)
        } catch { }
        
        return nil
    }
}
