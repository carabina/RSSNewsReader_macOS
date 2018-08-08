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
            self.articles.removeAll()
        
            reloadArticles()
        }
    }

    fileprivate var articles = [RSSArticle]()
    fileprivate var thumbnailCache = NSCache<NSString, NSImage>()
    
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
    func reloadArticles() {
        guard let providerName = provider?.title else {
            return
        }
        
        let fetchResult = CoreDataManager.shared.fetchArticles(providerName: providerName)
        
        guard fetchResult.error == nil else {
            AlertManager.shared.show(style: .critical, title: "뉴스 로딩 실패", message: fetchResult.error!.localizedDescription)
            return
        }
        
        if var fetchedArticles = fetchResult.articles, !fetchedArticles.isEmpty {
            fetchedArticles.sort(by: { $0.pubDate > $1.pubDate })
            
            if self.articles.isEmpty {
                insertNewArticles(fetchedArticles)
            } else if let firstArticle = self.articles.first, let firstFetched = fetchedArticles.first {
                // TODO: 이 부분 테스트를 어떻게 할지??
                if firstArticle.pubDate < firstFetched.pubDate {
                    insertNewArticlesWithAnim(fetchedArticles)
                }
            }
        }
    }
    
    func insertNewArticlesWithAnim(_ fetchedArticles: [RSSArticle]) {
        let newArticlesCnt = fetchedArticles.count - self.articles.count
        
        self.articles = fetchedArticles
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: IndexSet(integersIn: 0..<newArticlesCnt), withAnimation: NSTableView.AnimationOptions.slideDown)
        self.tableView.endUpdates()
    }
    
    func insertNewArticles(_ fetchedArticles: [RSSArticle]) {
        self.articles = fetchedArticles
        
        self.tableView.reloadData()
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
        
        if let diffDays = RSSUtil.diffBetweenDays(article.pubDate, Date()) {
            view.publishedAt.stringValue = (diffDays == 0) ? "오늘" : String(format: "%d일 전", diffDays)
        }
        
        // Thumbnail Cache
        if let thumbnailURL = article.thumbnailURL {
            if let cachedImage = thumbnailCache.object(forKey: NSString(string: thumbnailURL)) {
                view.thumbnail.image = cachedImage
            } else {
                view.thumbnail.setImage(url: thumbnailURL) { [weak self] (image, error) in
                    guard let weakSelf = self else { return }
                    guard let _image = image else { return }
                    
                    weakSelf.thumbnailCache.setObject(_image, forKey: NSString(string: thumbnailURL))
                }
            }
        }
        
        return view
    }
}
