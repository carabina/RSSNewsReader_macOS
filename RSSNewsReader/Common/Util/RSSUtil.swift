//
//  RSSUtil.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 27..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class RSSUtil: NSObject {
    class func diffBetweenDays(_ source: Date, _ target: Date) -> Int? {
        let calendar = Calendar.current
        let dateComponent = calendar.dateComponents([.day], from: source, to: target)
        
        return dateComponent.day
    }
}
