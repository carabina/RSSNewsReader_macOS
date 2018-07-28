//
//  FeedProviderCellView.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 2..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa

class FeedProviderCellView: NSTableCellView {
    @IBOutlet weak var feedImageView: NSImageView!
    @IBOutlet weak var feedTextField: NSTextField!
    @IBOutlet weak var feedTotalCnt: NSTextField!
    
    fileprivate let feedImageCache = NSCache<NSString, NSImage>()
    
    var feedImageURL: String? {
        didSet {
            guard let imageURL = feedImageURL else {
                return
            }
            
            if let cachedImage = feedImageCache.object(forKey: NSString(string: imageURL)) {
                feedImageView.image = cachedImage
            } else {
                NetworkService.image(url: imageURL) { [weak self] (image, error) in
                    guard error == nil else {
                        return
                    }
                    
                    guard let fetchedImage = image else {
                        return
                    }
                    
                    self?.feedImageCache.setObject(fetchedImage, forKey: NSString(string: imageURL))
                    
                    self?.feedImageView.image = fetchedImage
                }
            }
        }
    }
}
