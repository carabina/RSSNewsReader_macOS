//
//  CoreDataInterface.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 15..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

/// CoreData에 저장이 가능한 DataModel이 구현해야 할 프로토콜.
protocol CoreDataInterface {
    static func entity() -> String
}
