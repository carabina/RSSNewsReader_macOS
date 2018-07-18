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
    @IBOutlet weak var confirmBtn: NSButton!
    @IBOutlet weak var loadingIndicator: NSProgressIndicator!
    
    var isLoading = false {
        didSet {
            confirmBtn.isHidden = isLoading
            loadingIndicator.isHidden = !isLoading
            
            if isLoading {
                loadingIndicator.startAnimation(self)
            } else {
                loadingIndicator.stopAnimation(self)
            }
        }
    }
    
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
        
        isLoading = true
        
        NetworkService.shared.xml(url: stringURL) { [weak self] (data, error) in
            guard error == nil else {
                // TODO: 에러 메시지를 띄워야함.. 별도의 에러 메시지 처리를 담당하는 클래스가 필요.
                self?.isLoading = false
                return
            }
            
            guard let _data = data else {
                // TODO: 에러가 없는데 데이터가 nil일 경우가 있을까?
                self?.isLoading = false
                return
            }
            
            if let provider = RSSXmlParser.shared.parseProvider(data: _data) {
                if let error = CoreDataService.shared.save(provider) {
                    // TODO: error가 존재하면 알림창 띄워야 함!
                }
                
                self?.isLoading = false
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
