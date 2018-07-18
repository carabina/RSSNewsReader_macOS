//
//  AlertManager.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 19..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class AlertManager: NSObject {
    static let shared = AlertManager()
}

// MART: - Interface
extension AlertManager {
    
    func show(style: NSAlert.Style, title: String, message: String) {
        let alert = NSAlert()
        alert.alertStyle = style
        alert.messageText = title
        alert.informativeText = message
        alert.runModal()
    }
}
