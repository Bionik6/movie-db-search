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
    
    private let movies = [Movie.init(name: "Avengers 1", posterURL: "", releaseDate: "", overview: ""),
                          Movie.init(name: "Avengers 2", posterURL: "", releaseDate: "", overview: ""),
                          Movie.init(name: "Avengers 3", posterURL: "", releaseDate: "", overview: "")]
    
    override func setUp() {
        super.setUp()
        session = URLSessionMock()
        client = DispatcherMock(session: session)
        let service = mainAssembler?.resolver.resolve(SearchService.self)!
        sut = MovieDataProvider.init(searchService: service!)
        sut.movies = movies
    }
    
    func testIsLoadingIndexPath() {
        sut.shouldShowLoadingCell = true
        let indexPath = IndexPath(row: 3, section: 0)
        XCTAssertTrue(sut.isLoadingIndexPath(indexPath))
    }
    
    func testFetchNextPage() {
        XCTAssertEqual(sut.currentPage, 1)
        sut.fetchNextPage()
        XCTAssertEqual(sut.currentPage, 2)
        sut.fetchNextPage()
        XCTAssertEqual(sut.currentPage, 3)
    }
    
    func testMakeSearch() {
        var keyword = ""
        sut.makeSearch(for: keyword)
        XCTAssertEqual(sut.movies.count, 3)
        
        keyword = "spiderman"
        sut.makeSearch(for: keyword)
        XCTAssertEqual(sut.movies.count, 0)
        XCTAssertEqual(sut.searchTerms, keyword)
    }
    
    
}
