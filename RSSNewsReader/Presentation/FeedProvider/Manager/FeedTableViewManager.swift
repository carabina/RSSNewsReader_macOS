//
//  FeedTableViewManager.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 4..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class FeedTableViewManager: NSObject {
    let cellTitles = ["Outstanding", "TechNeedle"]
    var tableView: NSTableView!
    
    init(tableView: NSTableView) {
        super.init()
        
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.selectionHighlightStyle = .none
    }
}

extension FeedTableViewManager: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return cellTitles.count
    }
}

extension FeedTableViewManager: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("\(FeedProviderCellView.self)"), owner: self) as! FeedProviderCellView
        
        cell.feedTextField.stringValue = cellTitles[row]
        cell.feedTotalCnt.intValue = 5
        
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let rowView = tableView.rowView(atRow: tableView.selectedRow, makeIfNecessary: false)
        rowView?.isEmphasized = false
    }
}

