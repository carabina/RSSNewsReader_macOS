//
//  PreviewTblCell.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 4..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class PreviewTblCellView: NSTableCellView {
    @IBOutlet weak var thumbnail: NSImageView!
    @IBOutlet weak var articleTitle: NSTextField!
    @IBOutlet weak var providerName: NSTextField!
    @IBOutlet weak var publishedAt: NSTextField!
}
