//
//  NSImage+Extension.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 8. 8..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

extension NSImageView {
    func setImage(url: String) {
        self.setImage(url: url, completion: nil)
    }
    
    func setImage(url: String, completion: ((_ image: NSImage?, _ error: Error?) -> ())?) {
        NetworkService.image(url: url) { [weak self] (image, error) in
            self?.image = image
            
            completion?(image, error)
        }
    }
}
