//
//  Configuration.swift
//  TestSession
//
//  Created by arshad on 8/26/17.
//  Copyright © 2017 arshad. All rights reserved.
//

import Foundation

struct Config {
    static let urlSession: URLSessionProtocol = UITesting() ? SeededURLSession() : URLSession.shared
}

private func UITesting() -> Bool {
    return ProcessInfo.processInfo.arguments.contains("UI-TESTING")
}
