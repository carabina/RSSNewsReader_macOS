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
    @IBOutlet weak var tableView: NSTableView!
    
    let cellTitles = ["Outstaning", "TechNeedle"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize = NSSize(width: 200, height: 500)
        
        topbarView.wantsLayer = true
        topbarView.layer?.backgroundColor = NSColor.hex(0xf6f6f6).cgColor
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
}

extension FeedProviderViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return cellTitles.count
    }
}

extension FeedProviderViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if tableColumn?.identifier.rawValue == "ProviderInfo" {
            let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("\(FeedProviderCellView.self)"), owner: self) as! FeedProviderCellView
            cell.feedTextField.stringValue = cellTitles[row]
            
            return cell
        } else if tableColumn?.identifier.rawValue == "FeedCount" {
            let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as! NSTableCellView
            cell.textField?.stringValue = "32"
            
            return cell
        }
        
        return nil
    }
}
