//
//  HTTPMethodTests.swift
//  MovieDBSearchTests
//
//  Created by Ibrahima Ciss on 8/1/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import XCTest
@testable import MovieDBSearch

class HTTPMethodTests: XCTestCase {
    
    var sut: HTTPMethod?
    
    override func setUp() {
        super.setUp()
    }
    
    func testSutHasGetCase() {
        sut = HTTPMethod.get
        XCTAssertEqual(sut!.rawValue, "GET")
    }
    
    func testSutHasPostCase() {
        sut = HTTPMethod.post
        XCTAssertEqual(sut!.rawValue, "POST")
    }
    
    func testSutHasPutCase() {
        sut = HTTPMethod.put
        XCTAssertEqual(sut!.rawValue, "PUT")
    }
    
    func testSutHasPatchCase() {
        sut = HTTPMethod.patch
        XCTAssertEqual(sut!.rawValue, "PATCH")
    }
    
    func testSutHasDeleteCase() {
        sut = HTTPMethod.delete
        XCTAssertEqual(sut!.rawValue, "DELETE")
    }
    
}
