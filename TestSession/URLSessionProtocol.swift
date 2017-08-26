//
//  URLSessionProtocol.swift
//  TestSession
//
//  Created by arshad on 8/26/17.
//  Copyright © 2017 arshad. All rights reserved.
//

import Foundation

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
protocol URLSessionProtocol {
//    func dataTaskWithURL(url: NSURL, completionHandler: DataTaskResult)  -> URLSessionDataTask
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol

}

extension URLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {

        return (dataTask(with: url, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
        
    }

}
