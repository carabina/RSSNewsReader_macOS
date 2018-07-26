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
        Timer.scheduledTimer(withTimeInterval: dispatchInterval, repeats: true) { [weak self] timer in
            self?.dispatch {
                onCompletion()
            }
        }
    }
    
    func dispatch(onCompletion: (() -> ())?) {
        guard let providers = CoreDataManager.shared.fetchProvider().provider else {
            return
        }
        
        var remainCnt = providers.count {
            didSet {
                if remainCnt == 0 {
                    NotificationCenter.default.post(name: NSNotification.Name.newArticlesAdded, object: self)
                    onCompletion?()
                }
            }
        }
        
        providers.forEach { provider in
            NetworkService.shared.xml(url: provider.link, onCompletion: { (data, error) in
                // 데이터가 없거나 파싱 에러가 발생하면 API 완료 처리함.
                guard let _data = data, error == nil else {
                    remainCnt -= 1
                    return
                }
                
                if let articles = RSSXmlParser.shared.parseArticles(data: _data) {
                    if let error = CoreDataManager.shared.save(articles: articles) {
                        // TODO: 에러 처리 어떻게?? Alert로 띄우면 사알짝 거시기 함.
                        print(error)
                    }
                    
                    remainCnt -= 1
                }
            })
        }
    }
}
