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
        sut = MovieDataProvider(client: client)
    }
    
    
    func testFetchMovies() {
        sut.fetchMovies(for: "toto") { response in
            XCTAssertTrue(self.session.isDataTaskCalled)
            switch response {
            case .success(let data):
                XCTAssertEqual(self.session.data, data)
            case .failure(let error):
                XCTAssertEqual(self.session.error, error)
            }
        }
        
    }
    
    
}
