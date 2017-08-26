//
//  HTTPClientTests_Integration.swift
//  TestSession
//
//  Created by arshad on 8/26/17.
//  Copyright © 2017 arshad. All rights reserved.
//

import XCTest
@testable import TestSession

class HTTPClientTests_Integration: XCTestCase {
    
    let httpClient = HTTPClient()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNetworkConnection() {

        let url = URL(string: "https://google.com")!
        let exp = expectation(description: "Wait for \(url) to load")
        var theData: Data?
        httpClient.get(url: url) { (data, error) in
            
            theData = data
            XCTAssertNil(error)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(theData)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
