//
//  HTTPClient.swift
//  TestSession
//
//  Created by arshad on 8/26/17.
//  Copyright © 2017 arshad. All rights reserved.
//

import Foundation

typealias HTTPResult = (Data?, Error?) -> Void

class HTTPClient {
    private let session: URLSessionProtocol
    
    /*init(session: URLSession = Config.urlSession) {
        self.session = session
    }*/
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func get(url: URL, completion: @escaping HTTPResult) {
        let task = session.dataTask( with: url) { (data, response, error) -> Void in
                    
            if let _ = error {
                completion(nil, error)
            } else if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                completion(data, nil)
            } else {
                completion(nil, error)
            }
        
        }
        task.resume()
    }
    
}


