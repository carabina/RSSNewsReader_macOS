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
        let url = "http://techneedle.com/feed"
        
        NetworkService.xml(url: url) { (data, error) in
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            
            let provider = RSSXmlParser.parseProvider(data: data!)
            
            XCTAssertNotNil(provider.name)
            XCTAssertNotNil(provider.introduce)
            
            expt.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testParsingArticles() {
        let expt = expectation(description: "testParsingArticles")
        let url = "http://techneedle.com/feed"
        
        NetworkService.xml(url: url) { (data, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            
            let articles = RSSXmlParser.parseArticles(data: data!)
            articles.forEach { article in
                XCTAssertNotNil(article.title)
                XCTAssertNotNil(article.link)
                XCTAssertNotNil(article.pubDate)
                XCTAssertNotNil(article.contents)
            }
            
            expt.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
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
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
