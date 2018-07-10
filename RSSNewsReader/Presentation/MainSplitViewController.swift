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

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    // MARK: - Interface
    func showAddProviderView() {
        let view = FeedProviderAddView.initFromNib()
        view.frame.origin.x = 100
        view.frame.origin.y = 0
        
        self.view.addSubview(view)
    }
}

// MARK: - FeedProviderAddViewDelegate
extension MainSplitViewController: FeedProviderAddViewDelegate {
    func didCancelBtnTapped() {
        
    }
}
