//
//  RSSProvider.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 7..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class RSSProvider: NSObject {
    var name: String!
    var introduce: String!
    var image: NSImage?
    
    var imageURL: String? {
        didSet {
            guard let _imageURL = imageURL else { return }
            NetworkService.image(url: _imageURL) { [weak self] (image, error) in
                if (error == nil) {
                    self?.image = image
                }
            }
        }
    }
}
