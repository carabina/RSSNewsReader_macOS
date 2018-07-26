//
//  RSSIndicatorView.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 26..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class RSSIndicatorView: NSView {
    @IBOutlet weak var refreshImageView: NSImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        refreshImageView.startRotate(timeToRotate: 0.2)
    }
}

extension RSSIndicatorView: ViewInterface {
    class func initFromNib() -> Self {
        return initFromNib(nibName: "\(RSSIndicatorView.self)")
    }
}
