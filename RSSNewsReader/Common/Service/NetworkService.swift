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
    static let shared = NetworkService()
    
    func image(url: String, onCompletion: @escaping (_ image: NSImage?, _ error: Error?) -> ()) {
        var headers = HTTPHeaders()
        headers["Accept"] = "image/png"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
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
    
    func xml(url: String, onCompletion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        var headers = HTTPHeaders()
        headers["Accept"] = "application/rss+xml"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate()
            .response { response in
                onCompletion(response.data, response.error)
            }
    }
}
