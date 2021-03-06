//
//  SearchViewControllerTests.swift
//  MovieDBSearchTests
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import XCTest
@testable import MovieDBSearch

class SearchViewControllerTests: XCTestCase {
    
    var sut: SearchViewController!
    
    override func setUp() {
        super.setUp()
        sut = SearchViewController(nibName: nil, bundle: nil)
        sut.loadViewIfNeeded()
    }
    
    func testMainViewIsOfTypeSearchView() {
        XCTAssertTrue(sut.view is SearchView, "Main View should be of type SearchView")
    }
    
    func testSutTitle() {
        let expectedTitle = "MOVIE DB Search"
        XCTAssertEqual(sut.title, expectedTitle)
    }
    
    func testSutViewPropertiesAreNotNil() {
        XCTAssertNotNil(sut.searchTextField)
        XCTAssertNotNil(sut.tableView)
        XCTAssertNotNil(sut.suggestionTableView)
    }
    
    func testSutTableViewsSetDataSource() {
        XCTAssertTrue(sut.tableView?.dataSource is MovieDataProvider)
        XCTAssertTrue(sut.tableView?.delegate is MovieDataProvider)
        XCTAssertTrue(sut.suggestionTableView?.dataSource is SuggestionDataProvider)
    }
    
}
