//
//  PreviewTableCellView.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 3..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class PreviewTableCellView: NSTableCellView {
    @IBOutlet weak var thumbnail: NSImageView!
    @IBOutlet weak var title: NSTextField!
    @IBOutlet weak var providerThumbnail: NSImageView!
    @IBOutlet weak var providerName: NSTextField!
}
