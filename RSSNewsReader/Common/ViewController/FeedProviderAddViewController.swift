//
//  FeedProviderAddViewController.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 10..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class FeedProviderAddViewController: NSViewController {
    @IBOutlet weak var textField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didAddBtnTapped(_ sender: Any) {
        
    }
    
    @IBAction func didCancelBtnTapped(_ sender: Any) {
        dismissViewController(self)
    }
}

extension FeedProviderAddViewController: ViewControllerInterface {
    class func instance() -> Self {
        return instance(storyboardName: "FeedProviderAdd", identifier: "\(FeedProviderAddViewController.self)")
    }
}
