//
//  FeedTableViewManager.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 4..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class FeedTableViewManager: NSObject {

    fileprivate var tableView: NSTableView!
    fileprivate var providers = [RSSProvider]()
    
    init(tableView: NSTableView) {
        super.init()
        
        self.tableView = tableView
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = NSColor.clear
        tableView.selectionHighlightStyle = .none
        
        reloadTableView()
    }
}

// MARK: - Interface
extension FeedTableViewManager {
    func reloadTableView() {
        let tuple = CoreDataManager.shared.fetchProvider()
        
        guard let providers = tuple.provider, !providers.isEmpty else {
            return
        }
        
        guard tuple.error == nil else {
            AlertManager.shared.show(style: .critical, title: "웹사이트 로딩 실패", message: tuple.error!.localizedDescription)
            return
        }
        
        self.providers = providers
        
        self.tableView.reloadData()
    }
}

// MARK: - NSTableViewDataSource
extension FeedTableViewManager: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return providers.count
    }
}

// MARK: - NSTableVIewDelegate
extension FeedTableViewManager: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("\(FeedProviderCellView.self)"), owner: self) as! FeedProviderCellView
        let provider = providers[row]
        
        cell.feedImageView.image = provider.image
        cell.feedTextField.stringValue = provider.title
        cell.feedTotalCnt.intValue = 5
        
        return cell
    }
}

