//
//  FeedProviderViewController.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 2..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class FeedProviderViewController: NSViewController {
    @IBOutlet weak var plusBtn: NSButton!
    @IBOutlet weak var refreshBtn: NSButton!
    
    @IBOutlet weak var topbarView: NSView!
    @IBOutlet weak var fixedTableView: NSTableView!
    @IBOutlet weak var feedTableView: NSTableView!
    
    fileprivate var fixedTblManager: FixedTableViewManager!
    fileprivate var feedTblManager: FeedTableViewManager!
    
    let cellTitles = ["Outstaning", "TechNeedle"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize = NSSize(width: 200, height: 500)
 
        fixedTblManager = FixedTableViewManager(tableView: fixedTableView)
        feedTblManager = FeedTableViewManager(tableView: feedTableView)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    // MARK: - Button Action
    
    @IBAction func didPlusBtnTapped(_ sender: Any) {
        if let parent = parent as? MainSplitViewController {
            parent.showAddProviderView()
        }
    }
    
    @IBAction func didRefreshBtnTapped(_ sender: Any) {
    }
}
