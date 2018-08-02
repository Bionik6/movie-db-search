//
//  RequestParamsTests.swift
//  MovieDBSearchTests
//
//  Created by Ibrahima Ciss on 8/1/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import XCTest
@testable import MovieDBSearch

class RequestParamsTests: XCTestCase {
    
    var sut: RequestParams?
    
    override func setUp() {
        super.setUp()
        sut = nil
    }
    
    func testSutHasBodyCaseWithADataAssociated() {
        let dict: [String: Any] = ["items": 5, "last": false, "category": "diner"]
        sut = RequestParams.body(dict)
        if case .url(let urlParams) = sut! {
            XCTAssertEqual(urlParams.capacity, dict.capacity)
            XCTAssertEqual(urlParams["items"] as! Int, 5)
            XCTAssertEqual(urlParams["last"] as! Bool, false)
            XCTAssertEqual(urlParams["category"] as! String, "diner")
        }
    }
    
    func testSutHasUrlCaseWithAssociatedData() {
        let dict: [String: Any] = ["items": 5, "last": false, "category": "diner"]
        sut = RequestParams.url(dict)
        if case .url(let urlParams) = sut! {
            XCTAssertEqual(urlParams.capacity, dict.capacity)
            XCTAssertEqual(urlParams["items"] as! Int, 5)
            XCTAssertEqual(urlParams["last"] as! Bool, false)
            XCTAssertEqual(urlParams["category"] as! String, "diner")
        }
    }
    
}
