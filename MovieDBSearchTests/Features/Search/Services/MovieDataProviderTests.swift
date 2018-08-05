//
//  MovieDataProviderTests.swift
//  MovieDBSearchTests
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import XCTest
@testable import MovieDBSearch

class MovieDataProviderTests: XCTestCase {
    
    private var sut: MovieDataProvider!
    private var client: Dispatcher!
    private var session: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        session = URLSessionMock()
        client = DispatcherMock(session: session)
        sut = MovieDataProvider.init()
    }
    
    
    func testFetchMovies() {
        sut.factory.fetchMovies(for: "toto", page: 1) { response in
            XCTAssertTrue(self.session.isDataTaskCalled)
        }
        
    }
    
    
}
