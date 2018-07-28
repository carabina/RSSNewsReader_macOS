//
//  RSSNotification.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 10..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

extension NSNotification.Name {
    /// 새로운 웹사이트 (뉴스 제공자)가 추가됨.
    static let newProviderAdded = NSNotification.Name("newProviderAdded")
    /// 새로운 뉴스 기사를 받아옴.
    static let newArticlesAdded = NSNotification.Name("newArticlesAdded")
    /// 뉴스 기사를 받아오는 중임.
    static let fetchingArticles = NSNotification.Name("fetchingArticles")
}
