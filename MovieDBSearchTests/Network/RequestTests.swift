//
//  RequestTests.swift
//  MovieDBSearchTests
//
//  Created by Ibrahima Ciss on 8/1/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import XCTest
@testable import MovieDBSearch

class RequestTests: XCTestCase {
    
    var sut: Request?
    
    override func setUp() {
        super.setUp()
        sut = RequestMock()
    }
    
    func testSutHasAPath() {
        XCTAssertEqual(sut!.path, "/users")
    }
    
    func testSutHasHTTPMethod() {
        XCTAssertEqual(sut!.method, HTTPMethod.get)
    }
    
    func testSutHasParameters() {
        let params = RequestParams.url(["page": 2, "items": 50])
        XCTAssertEqual(sut!.params!, params)
    }
    
    func testSutHasHeaders() {
        let headers = ["Authorization": "Bearer tokenhere"]
        XCTAssertEqual(sut!.headers!, headers)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
}
