//
//  RSSNewsReaderTests.swift
//  RSSNewsReaderTests
//
//  Created by 이승준 on 2018. 7. 2..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import XCTest
import Alamofire
import SWXMLHash
@testable import RSSNewsReader

class RSSNewsReaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - XML Parsing Test
    func testParsingProvider() {
        let expt = expectation(description: "testParsingProvider")
        
        let rssURL = "http://techneedle.com/feed"
        let normalURL = "http://techneedle.com"
                
        NetworkService.xml(url: rssURL) { (data, error) in
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            
            let provider = RSSXmlParser.parseProvider(linkURL: rssURL, data: data!)
            
            XCTAssertNotNil(provider)
            XCTAssertNotNil(provider!.title)
            XCTAssertNotNil(provider!.introduce)
            
            NetworkService.xml(url: normalURL) { (data, error) in
                XCTAssertNotNil(data)
                XCTAssertNotNil(error)
                
                expt.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testParsingArticles() {
        let expt = expectation(description: "testParsingArticles")
        
        let rssURL = "http://techneedle.com/feed"
        let normalURL = "http://techneedle.com"
        
        NetworkService.xml(url: rssURL) { (data, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            
            let articles = RSSXmlParser.parseArticles(data: data!)
            
            XCTAssertNotNil(articles)
            
            articles!.forEach { article in
                XCTAssertNotNil(article.title)
                XCTAssertNotNil(article.link)
                XCTAssertNotNil(article.pubDate)
                XCTAssertNotNil(article.contents)
            }
            
            NetworkService.xml(url: normalURL, onCompletion: { (data, error) in
                XCTAssertNotNil(data)
                XCTAssertNotNil(error)
                
                expt.fulfill()
            })
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - CoreData Test
    func testRemoveAllEntitiesOfCoreProvider() {
        let error = CoreDataManager.shared.removeAllProviders()
        
        XCTAssertNil(error)
    }
    
    func testRemoveAllEntitiesOfCoreArticle() {
        let error = CoreDataManager.shared.removeAllArticles(providerName: "테크니들")
        
        XCTAssertNil(error)
    }
    
    // MARK: - Http Test
    func testAccessHttpImage() {
        let expt = expectation(description: "testAccessHttpImage")
        let url = "https://i2.wp.com/techneedle.com/wp-content/uploads/2018/03/cropped-tN-favicon.png?fit=32%2C32"
        
        NetworkService.image(url: url) { (image, error) in
            XCTAssertNotNil(image)
            XCTAssertNil(error)
            
            expt.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Misc
    func testStringToDate() {
        let dateString = "Thu, 28 Jun 2018 15:30:27 +0000"
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss +zzzz"
        dateFormatter.locale = Locale(identifier: "US_en")
        
        let date = dateFormatter.date(from: dateString)
        
        XCTAssertNotNil(date)
    }
    
}
