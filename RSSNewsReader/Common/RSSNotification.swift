//
//  RSSNotification.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 10..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

extension NSNotification.Name {
    /// 새로운 웹사이트 (뉴스피드 제공자)가 추가됨.
    static var newProviderAdded = NSNotification.Name.init("newProviderAdded")
}
