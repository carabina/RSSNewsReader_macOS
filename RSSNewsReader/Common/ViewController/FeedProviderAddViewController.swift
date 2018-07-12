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
        
        textField.delegate = self
    }
    
    // MARK: - Button Action
    
    @IBAction func didAddBtnTapped(_ sender: Any) {
        requestAddProvider()
    }
    
    @IBAction func didCancelBtnTapped(_ sender: Any) {
        dismissViewController(self)
    }
}

// MARK: - NSTextFieldDelegate
extension FeedProviderAddViewController: NSTextFieldDelegate {
    override func controlTextDidEndEditing(_ obj: Notification) {
        requestAddProvider()
    }
}

// MARK: - Internal
fileprivate extension FeedProviderAddViewController {
    func requestAddProvider() {
        guard !textField.stringValue.isEmpty else { return }
        
        var stringURL = textField.stringValue
        
        if !stringURL.hasPrefix("http://") {
            stringURL.insert(contentsOf: "http://", at: stringURL.startIndex)
        }
        
        NetworkService.shared.xml(url: stringURL) { (data, error) in
            guard error == nil else {
                // TODO: 에러 메시지를 띄워야함.. 별도의 에러 메시지 처리를 담당하는 클래스가 필요.
                print(error?.localizedDescription)
                return
            }
            
            if let _data = data {
                RSSXmlParser.shared.parseProvider(data: _data)
                
            }
        }
    }
}

// MARK: - ViewControllerInterface
extension FeedProviderAddViewController: ViewControllerInterface {
    class func instance() -> Self {
        return instance(storyboardName: "FeedProviderAdd", identifier: "\(FeedProviderAddViewController.self)")
    }
}
