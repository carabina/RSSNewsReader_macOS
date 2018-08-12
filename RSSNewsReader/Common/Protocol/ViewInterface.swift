//
//  ViewInterface.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 4..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

protocol ViewInterface { }

extension ViewInterface where Self: NSView {
    static func initFromNib() -> Self {
        fatalError("You must override and implement this method")
    }
    
    static func initFromNib(nibName: String) -> Self {
        var topLevelObjects: NSArray?
        
        if Bundle.main.loadNibNamed(NSNib.Name(nibName), owner: self, topLevelObjects: &topLevelObjects) {
            let topLevelObj = topLevelObjects?
                .filter { $0 is Self }
                .first
            
            if let view = topLevelObj as? Self {
                return view
            }
        }
        
        fatalError("Can't find \(Self.self) from \(nibName).xib")
    }
}
