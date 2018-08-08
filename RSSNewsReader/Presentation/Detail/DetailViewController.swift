//
//  DetailViewController.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 5..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa
import WebKit

class DetailViewController: NSViewController {
    @IBOutlet weak var starButton: NSButton!
    @IBOutlet weak var webView: WKWebView!
    
    var article: RSSArticle? {
        didSet {
            guard let _article = article else { return }
            guard let url = URL(string: _article.link) else { return }
            
            webView.load(URLRequest(url: url))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Internals
fileprivate extension DetailViewController {
    
}
