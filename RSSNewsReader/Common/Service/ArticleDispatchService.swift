//
//  ArticleDispatchService.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 21..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

/// 일정 시간마다 뉴스 제공자의 사이트에 접근하여 신규 기사를 가져오는 클래스.
class ArticleDispatchService: NSObject {
    static let shared = ArticleDispatchService()
    
    var dispatchInterval: TimeInterval = 5 * 60 // default: 5분 간격으로 dispatch.
}

// MARK: - Interface
extension ArticleDispatchService {
    func startTimer() {
        
    }
}
