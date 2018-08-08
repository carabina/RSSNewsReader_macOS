//
//  ViewController.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 2..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class MainSplitViewController: NSSplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var previewViewController: PreviewViewController? {
        return (self.childViewControllers.filter { $0.className == PreviewViewController.className() }.first) as? PreviewViewController
    }
    
    var detailViewController: DetailViewController? {
        return (self.childViewControllers.filter { $0.className == DetailViewController.className() }.first) as? DetailViewController
    }
}

// MARK: - Interface
extension MainSplitViewController {
    func showAddProviderView() {
        let vc = FeedProviderAddViewController.instance()
        presentViewControllerAsSheet(vc)
    }
}

// MARK: - Internal
fileprivate extension MainSplitViewController {
    
}
