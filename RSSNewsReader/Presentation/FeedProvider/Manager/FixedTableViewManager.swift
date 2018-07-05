//
//  FixedTableViewManager.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 4..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class FixedTableViewManager: NSObject {
    fileprivate let titles = ["전체 기사 보기", "별표한 기사만 보기"]
}

extension FixedTableViewManager: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return titles.count
    }
}

extension FixedTableViewManager: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("\(FeedProviderCellView.self)"), owner: self) as! FeedProviderCellView
        
        cell.feedTextField.stringValue = titles[row]
        cell.feedTotalCnt.intValue = 5
        
        return cell
    }
}
