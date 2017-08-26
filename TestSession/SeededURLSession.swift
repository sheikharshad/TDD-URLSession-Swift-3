//
//  SeededURLSession.swift
//  TestSession
//
//  Created by arshad on 8/26/17.
//  Copyright © 2017 arshad. All rights reserved.
//

import Foundation

typealias DataCompletion = (Data?, URLResponse?, Error?) -> Void

class SeededURLSession: URLSession {
    override func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        
        return SeededDataTask(url: url, completion: completionHandler)
        
    }
}

class SeededDataTask: URLSessionDataTask {
    private let url: URL
    private let completion: DataCompletion
    private let realSession: URLSessionProtocol = URLSession.shared
    init(url: URL, completion: @escaping DataCompletion) {
        self.url = url
        self.completion = completion
    }

    override func resume() {
        if let json = ProcessInfo.processInfo.environment[url.absoluteString] {
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            let data = json.data(using: String.Encoding.utf8)
            completion(data, response, nil)
        } else {
            _ = realSession.dataTask(with: url, completionHandler: completion)
        }
    }
}
