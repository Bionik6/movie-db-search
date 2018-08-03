//
//  APIClientTests.swift
//  MovieDBSearchTests
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import XCTest
@testable import MovieDBSearch

class APIClientTests: XCTestCase {
    
    var sut: APIClient!
    var sessionMock: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        sessionMock = URLSessionMock()
        sut = APIClient(session: sessionMock)
    }
    
    func testExecute() {
        let request = RequestMock.init()
        sut.execute(request: request) { response in
            XCTAssertTrue(self.sessionMock.isDataTaskCalled)
            switch response {
            case .success(let data):
                XCTAssertEqual(self.sessionMock.data, data)
            case .failure(let error):
                XCTAssertEqual(self.sessionMock.error, error)
            }
        }
    }

}
