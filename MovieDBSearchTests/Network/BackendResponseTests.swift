//
//  BackendResponseTests.swift
//  MovieDBSearchTests
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import XCTest
@testable import MovieDBSearch

class BackendResponseTests: XCTestCase {
    
    private var sut: BackendResponse<Data>!
    private var data: Data!
    private var error: ResponseError!
    
    override func setUp() {
        super.setUp()
        data = Data(bytes: [0, 1, 0, 1])
        error = ResponseError.noInternetConnection
    }
    
    func testSutHasSuccessCaseWithAssociatedData() {
        sut = BackendResponse.success(data)
        if case let .success(data) = sut! {
            XCTAssertEqual(data, self.data)
        }
    }
    
    func testSutHasFailureCaseWithAssociatedData() {
        sut = BackendResponse.failure(error)
        if case let .failure(error) = sut! {
            XCTAssertEqual(error, self.error)
        }
    }
    
}
