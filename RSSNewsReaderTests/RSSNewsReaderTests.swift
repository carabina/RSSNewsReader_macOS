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
        // Async 테스트 케이스 작성은 아래 URL 참고해양
        // http://seorenn.blogspot.com/2016/11/xcode-asynchronous-unittest.html
        let testFeedURL = "http://techneedle.com/feed/"
        
        Alamofire.request(testFeedURL).response { response in
            debugPrint(response)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
