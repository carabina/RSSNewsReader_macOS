//
//  ViewControllerInterface.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 10..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

protocol ViewControllerInterface {
    // Empty
}

extension ViewControllerInterface where Self: NSViewController {
    static func instance() -> Self {
        fatalError("You must override and implement this method")
    }
    
    // 어떻게 할지 생각해보자...
//    static func instance(storyboadName: String, viewController: NSViewController) -> Self {
//        let storyboard = NSStoryboard(name: NSStoryboard.Name(storyboadName), bundle: nil)
//
//    }
}
