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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.preferredContentSize = NSSize(width: 350, height: 600)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension PreviewViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 5
    }
}

extension PreviewViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "\(PreviewTblCellView.self)"), owner: self)
        
        return view
    }
}
