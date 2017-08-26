//
//  HTTPClientTests.swift
//  TestSession
//
//  Created by arshad on 8/26/17.
//  Copyright © 2017 arshad. All rights reserved.
//

import XCTest
@testable import TestSession

class HTTPClientTests: XCTestCase {

    var subject: HTTPClient!
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        subject = HTTPClient(session: session)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func test_GET_RequestsTheURL() {
        let url = URL(string: "http://masilotti.com")
        subject.get(url: url!) { (_, _) -> Void in }
        
        XCTAssert(session.lastURL == url)
    }
    
    
    func test_GET_StartsTheRequest() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        let url = URL(string: "http://masilotti.com")
        subject.get(url: url!) { (_, _) -> Void in }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_GET_ReturnsData() {
        let url = URL(string: "http://masilotti.com")!
        let expectedData = "{}".data(using: String.Encoding.utf8)
        session.nextData = expectedData
        session.nextResponse =  HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: "2", headerFields: [:])

        let exp = expectation(description: "Wait for \(String(describing: url)) to load.")
        var data: Data?
        subject.get(url: url) { (theData, error) -> Void in
            data = theData
            exp.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil) //as we are putting hard coded value we can remove wait stuff
        XCTAssertNotNil(data)
    }

    //since we are hard coding the flow we can remove the expectation
    func  test_GET_WithResponseData_ReturnsTheData() {
        let url = URL(string: "http://masilotti.com")!
        let expectedData = "{}".data(using: String.Encoding.utf8)
        session.nextData = expectedData
        session.nextResponse =  HTTPURLResponse(statusCode: 200)
        
        var actualData: Data?
        subject.get(url: url) { (theData, error) -> Void in
            actualData = theData
        }
        XCTAssertEqual(expectedData, actualData)
    }
    
    func test_GET_WithANetworkError_ReturnsANetworkError() {
        session.nextError = NSError(domain: "error", code: 0, userInfo: nil)
        
        var error: Error?
        let url = URL(string: "http://garbafeom")!
        subject.get(url: url) { (_, theError) -> Void in
            error = theError
        }
        XCTAssertNotNil(error)
    }

    func test_GET_WithAStatusCodeLessThan200_ReturnsAnError() {
        let url = URL(string: "http://masilotti.com")!

        session.nextResponse =  HTTPURLResponse(statusCode: 199)
        session.nextError = NSError(domain: "error", code: 199, userInfo: nil)
        var error: Error?
        subject.get(url: url) { (_, theError) -> Void in
            error = theError
        }
        
        XCTAssertNotNil(error)
    }
    
    func test_GET_WithAStatusCodeGreaterThan299_ReturnsAnError() {
        let url = URL(string: "http://masilotti.com")!

        session.nextResponse =  HTTPURLResponse(statusCode: 300)
        session.nextError = NSError(domain: "error", code: 300, userInfo: nil)
        
        var error: Error?
        subject.get(url: url) { (_, theError) -> Void in
            error = theError
        }
        
        XCTAssertNotNil(error)
    }

    
    

}

extension HTTPURLResponse {
    convenience init?(statusCode: Int) {
        self.init(url:URL(string: "http://masilotti.com")!, statusCode: statusCode,
             httpVersion: nil, headerFields: nil)
    }
}
