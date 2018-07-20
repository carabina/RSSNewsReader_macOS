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
        textField.delegate = nil
        
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
            guard let weakSelf = self else {
                return
            }
            
            guard error == nil else {
                AlertManager.shared.show(style: .critical, title: "웹사이트 추가 실패", message: "해당 웹사이트에서 제공하는 뉴스를 정상적으로 가져오지 못했습니다.")
                
                weakSelf.isLoading = false
                
                return
            }
            
            guard let _data = data else {
                // TODO: 에러가 없는데 데이터가 nil일 경우가 있을까?
                weakSelf.isLoading = false
                
                return
            }
            
            if let provider = RSSXmlParser.shared.parseProvider(data: _data) {
                if let error = CoreDataManager.shared.save(provider: provider) {
                    AlertManager.shared.show(style: .critical, title: "웹사이트 추가 실패", message: error.localizedDescription)
                    
                    weakSelf.isLoading = false
                } else {
                    NotificationCenter.default.post(name: NSNotification.Name.newProviderAdded, object: self)
                    
                    weakSelf.textField.delegate = nil
                    weakSelf.dismissViewController(weakSelf)
                }
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
