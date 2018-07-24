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
    func startTimer(onCompletion: @escaping () -> ()) {
        Timer.scheduledTimer(withTimeInterval: dispatchInterval, repeats: true) { timer in
            guard let providers = CoreDataManager.shared.fetchProvider().provider else {
                return
            }
            
            var remainCnt = providers.count {
                didSet {
                    if remainCnt == 0 {
                        onCompletion()
                    }
                }
            }
            
            providers.forEach { provider in
                // TODO: link에 접근하여 article을 받아온 이후 CoreData에 저장하자!
                // TODO: 중복된 기사는 저장이되면 안된다!
                NetworkService.shared.xml(url: provider.link, onCompletion: { (data, error) in
                    guard error == nil else {
                        remainCnt -= 1
                        return
                    }
                    
                    
                })
            }
        }
    }
}
