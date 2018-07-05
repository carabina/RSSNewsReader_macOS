//
//  FeedProviderViewController.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 2..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class FeedProviderViewController: NSViewController {

    @IBOutlet weak var topbarView: NSView!
    @IBOutlet weak var fixedTableView: NSTableView!
    @IBOutlet weak var feedTableView: NSTableView!
    
    fileprivate var fixedTblManager: FixedTableViewManager!
    fileprivate var feedTblManager: FeedTableViewManager!
    
    let cellTitles = ["Outstaning", "TechNeedle"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize = NSSize(width: 200, height: 500)
        
//        topbarView.wantsLayer = true
//        topbarView.layer?.backgroundColor = NSColor.hex(0xf6f6f6).cgColor
        
        fixedTblManager = FixedTableViewManager()
        feedTblManager = FeedTableViewManager()
        
        fixedTableView.dataSource = fixedTblManager
        fixedTableView.delegate = fixedTblManager
        
        feedTableView.dataSource = feedTblManager
        feedTableView.delegate = feedTblManager
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
}
