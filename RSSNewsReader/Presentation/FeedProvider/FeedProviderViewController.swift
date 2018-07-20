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
    @IBOutlet weak var refreshIndicator: NSProgressIndicator!
    
    @IBOutlet weak var topbarView: NSView!
    @IBOutlet weak var tableView: NSTableView!
    
    fileprivate var isLoading = false {
        didSet {
            refreshBtn.isHidden = isLoading
            refreshIndicator.isHidden = !isLoading
            
            if refreshIndicator.isHidden {
                refreshIndicator.stopAnimation(self)
            } else {
                refreshIndicator.startAnimation(self)
            }
        }
    }
    
    fileprivate var providers = [RSSProvider]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNewProviderAddedNotificationNotified(_:)), name: NSNotification.Name.newProviderAdded, object: nil)
        
        self.preferredContentSize = NSSize(width: 200, height: 500)
 
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = NSColor.clear
        self.tableView.selectionHighlightStyle = .none
        
        self.reloadData()
    }
    
    // MARK: - Button Action
    
    @IBAction func didPlusBtnTapped(_ sender: Any) {
        if let parent = parent as? MainSplitViewController {
            parent.showAddProviderView()
        }
    }
    
    @IBAction func didRefreshBtnTapped(_ sender: Any) {
        self.reloadData()
    }
    
    // MARK: - Notification
    
    @objc func onNewProviderAddedNotificationNotified(_ notification: NSNotification) {
        self.reloadData()
    }
}

// MARK: - Internal
fileprivate extension FeedProviderViewController {
    
    func reloadData() {
        self.isLoading = true
        
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
        
        self.isLoading = false
    }
}

// MARK: - NSTableViewDataSource
extension FeedProviderViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return providers.count
    }
}

// MARK: - NSTableVIewDelegate
extension FeedProviderViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("\(FeedProviderCellView.self)"), owner: self) as! FeedProviderCellView
        let provider = providers[row]
        
        cell.feedImageURL = provider.imageURL
        cell.feedTextField.stringValue = provider.title
        cell.feedTotalCnt.intValue = 5
        
        return cell
    }
}
