//
//  DispatcherTests.swift
//  MovieDBSearchTests
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import XCTest
@testable import MovieDBSearch

class DispatcherTests: XCTestCase {
    
    var sut: Dispatcher!
    var urlSessionMock: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        urlSessionMock = URLSessionMock()
        sut = DispatcherMock(session: urlSessionMock)
    }
    
    
    func testSuccessfulResponse() {
        let expectedData = Data(bytes: [0, 1, 0, 1])
        urlSessionMock.data = expectedData
        let request = RequestMock()
        
        sut.execute(request: request) { response in
            if case .success(let data) = response {
                XCTAssertEqual(data, expectedData)
            }
        }
    }
    
}
