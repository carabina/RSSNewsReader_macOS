//
//  PreviewViewController.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 3..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class PreviewViewController: NSViewController {
    @IBOutlet weak var tableView: NSTableView!
    
    var provider: RSSProvider? {
        didSet {
            // TODO: CoreData에 저장된 CoreArticle Loading.
        }
    }
    
    fileprivate var articles = [RSSArticle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize = NSSize(width: 350, height: 600)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.selectionHighlightStyle = .none
    }
}

// MARK: - NSTableViewDataSource
extension PreviewViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return articles.count
    }
}

// MARK: - NSTableViewDelegate
extension PreviewViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "\(PreviewTblCellView.self)"), owner: self)
        
        return view
    }
}
