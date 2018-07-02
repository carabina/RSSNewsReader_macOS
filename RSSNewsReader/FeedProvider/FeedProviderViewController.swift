//
//  FeedProviderViewController.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 2..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class FeedProviderViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    
    let cellTitles = ["Outstaning", "TechNeedle"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension FeedProviderViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return cellTitles.count
    }
}

extension FeedProviderViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("\(FeedProviderCellView.self)"), owner: self) as! FeedProviderCellView
        cell.feedTextField.stringValue = cellTitles[row]
        
        return cell
    }
}
