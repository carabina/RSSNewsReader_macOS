//
//  NetworkService.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 8..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa
import Alamofire

class NetworkService: NSObject {
    let shared = NetworkService()
    
    class func image(url: String, onCompletion: @escaping (_ image: NSImage?, _ error: Error?) -> ()) {
        var headers = HTTPHeaders()
        headers["Accept"] = "image"
        
        Alamofire.request(url)
            .validate()
            .response { response in
                guard response.error == nil else {
                    onCompletion(nil, response.error)
                    return
                }
                
                guard let data = response.data else {
                    onCompletion(nil, nil)
                    return
                }
                
                onCompletion(NSImage(data: data), nil)
            }
    }
    
    class func xml(url: String, onCompletion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        var headers = HTTPHeaders()
        headers["Accept"] = "application/rss+xml"
        
        Alamofire.request(url)
            .validate()
            .response { response in
                guard response.error == nil else {
                    onCompletion(nil, response.error)
                    return
                }
                
                onCompletion(response.data, nil)
            }
    }
}
