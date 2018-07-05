//
//  BGCustomView.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 5..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

/// Interface Builder에서 bg를 설정할 수 있는 NSView
@IBDesignable
class RSSView: NSView {
    @IBInspectable var bgColor: NSColor = NSColor.white {
        didSet {
            self.wantsLayer = true
            self.layer?.backgroundColor = bgColor.cgColor
        }
    }
}
