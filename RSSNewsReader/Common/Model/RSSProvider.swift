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
    var image: NSImage?
    
    var imageURL: String! {
        didSet {
            NetworkService.image(url: imageURL) { [weak self] (image, error) in
                if (error == nil) {
                    self?.image = image
                }
            }
        }
    }
}
