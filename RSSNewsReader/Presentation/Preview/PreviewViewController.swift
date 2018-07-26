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
            reloadArticles()
        }
    }

    fileprivate var articles = [RSSArticle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onNewArticleAddedNotification(_:)), name: NSNotification.Name.newArticlesAdded, object: nil)
        
        preferredContentSize = NSSize(width: 350, height: 600)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.selectionHighlightStyle = .none
    }
    
    // MARK: - Notification
    @objc func onNewArticleAddedNotification(_ notification: NSNotification) {
        reloadArticles()
    }
}

// MARK: - Internal
fileprivate extension PreviewViewController {
    // TODO: 새로운 기사가 추가되면 insert 해주자 (with animation)
    func reloadArticles() {
        guard let providerName = provider?.title else {
            return
        }
        
        let fetchResult = CoreDataManager.shared.fetchArticles(providerName: providerName)
        
        guard fetchResult.error == nil else {
            AlertManager.shared.show(style: .critical, title: "뉴스 로딩 실패", message: fetchResult.error!.localizedDescription)
            return
        }
        
        if let fetchedArticles = fetchResult.articles {
            self.articles = fetchedArticles
            self.tableView.reloadData()
        }
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
        let view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "\(PreviewTblCellView.self)"), owner: self) as! PreviewTblCellView
        let article = articles[row]
        
        view.providerName.stringValue = article.providerName
        view.articleTitle.stringValue = article.title
        //view.regDateAt.stringValue = article.pubDate
        
        return view
    }
}
