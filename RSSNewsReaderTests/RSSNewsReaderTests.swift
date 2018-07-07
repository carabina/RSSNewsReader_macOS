//
//  RSSNewsReaderTests.swift
//  RSSNewsReaderTests
//
//  Created by 이승준 on 2018. 7. 2..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import XCTest
import Alamofire
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
    
    func testAddFeedProvider() {
        let expt = expectation(description: "testAddFeedProvider")
        let testFeedURL = "http://techneedle.com/feed"
        
        var headers = HTTPHeaders()
        headers["Accept"] = "application/rss+xml"
        
        Alamofire.request(testFeedURL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate()
            .response { response in
                XCTAssertNil(response.error)
                XCTAssertNotNil(response.data)
                
                RSSXmlParser.shared.parse(data: response.data!)
                
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
