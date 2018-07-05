//
//  ViewInterface.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 4..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

protocol ViewInterface {
    // Empty
}

extension ViewInterface where Self: NSView {
    static func initFromNib() -> Self {
        fatalError("You must override and implement this method")
    }
}

extension ViewInterface {
//    static func initFromNib(_ nibName: String) -> Self {
//        let view = Bundle.main.loadNibNamed(<#T##nibName: NSNib.Name##NSNib.Name#>, owner: <#T##Any?#>, topLevelObjects: <#T##AutoreleasingUnsafeMutablePointer<NSArray?>?#>)
//        
//    }
}
