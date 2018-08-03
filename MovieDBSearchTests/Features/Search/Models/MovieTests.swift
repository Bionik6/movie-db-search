//
//  MovieTests.swift
//  MovieDBSearchTests
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import XCTest
@testable import MovieDBSearch

class MovieTests: XCTestCase {
    
    private var sut: Movie!
    
    override func setUp() {
        super.setUp()
        sut = Movie(name: "Avengers", posterURL: "url", releaseDate: "2018-01-01", overview: "movie overview")
    }
    
    func testSutProperties() {
        XCTAssertEqual(sut.name, "Avengers")
        XCTAssertEqual(sut.posterURL, "url")
        XCTAssertEqual(sut.releaseDate, "2018-01-01")
        XCTAssertEqual(sut.overview, "movie overview")
    }
    
}
