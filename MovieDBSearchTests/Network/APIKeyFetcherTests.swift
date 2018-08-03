//
//  APIKeyFetcherTests.swift
//  MovieDBSearchTests
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import XCTest
@testable import MovieDBSearch

class APIKeyFetcherTests: XCTestCase {
    
    private var sut: APIKeyFetcher!
    
    override func setUp() {
        super.setUp()
        sut = APIKeyFetcher()
    }
    
    func testFetchAPIKey() {
        let key = sut.fetchKey()
        XCTAssertNotNil(key)
    }
}
