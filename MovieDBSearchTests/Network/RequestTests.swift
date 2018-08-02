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
    
    class FakeRequest: Request {
        var path: String = "/users"
        var method: HTTPMethod = .get
        var params: RequestParams? = RequestParams.url(["page": 2, "items": 50])
        var headers: [String: String]? = ["Authorization": "Bearer tokenhere"]
    }
    
    override func setUp() {
        super.setUp()
        sut = FakeRequest()
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
