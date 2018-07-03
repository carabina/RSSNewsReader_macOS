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
        // Do view setup here.
    }
    
}

extension PreviewViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 5
    }
}

extension PreviewViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("\(PreviewTableCellView.self)"), owner: self)
    }
}
