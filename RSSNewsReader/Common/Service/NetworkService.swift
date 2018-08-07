//
//  NetworkService.swift
//  RSSNewsReader
//
//  Created by 이승준 on 2018. 7. 8..
//  Copyright © 2018년 seungjun. All rights reserved.
//

import Cocoa
import Alamofire

/// Http 통신을 담당하는 클래스
class NetworkService: NSObject { }

// MARK: - Interface
extension NetworkService {
    class func image(url: String, onCompletion: @escaping (_ image: NSImage?, _ error: Error?) -> ()) {
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
    
    class func xml(url: String, onCompletion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        var headers = HTTPHeaders()
        headers["Accept"] = "text/xml; application/rss+xml; application/xml"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate()
            .response { response in
                onCompletion(response.data, response.error)
            }
    }
}
