//
//  URLSessionDataTaskProtocol.swift
//  TestSession
//
//  Created by arshad on 8/26/17.
//  Copyright © 2017 arshad. All rights reserved.
//

import Foundation


protocol URLSessionDataTaskProtocol {

    func resume()

}

extension URLSessionDataTask: URLSessionDataTaskProtocol {

}
