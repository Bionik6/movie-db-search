//
//  SearchRequestTests.swift
//  MovieDBSearchTests
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import XCTest
@testable import MovieDBSearch

class SearchRequestTests: XCTestCase {
    
    private var sut: SearchRequest!
    
    override func setUp() {
        super.setUp()
        sut = SearchRequest(searchTerms: "avengers", page: 1)
    }
    
    func testSutHasCorrectPath() {
        let expectedPath = "search/movie"
        XCTAssertEqual(sut.path, expectedPath)
    }
    
    func testSutHasCorrectMethod() {
        XCTAssertEqual(sut.method, .get)
    }
    
    func testSutHasCorrectParams() {
        switch sut.params! {
        case .url(let params):
            XCTAssertEqual(params["query"] as! String, "avengers")
            XCTAssertNotNil(params["api_key"])
        default: break
        }
    }
    
    func testSutHasNoHeaders() {
        XCTAssertNil(sut.headers)
    }
    
  
    
}
