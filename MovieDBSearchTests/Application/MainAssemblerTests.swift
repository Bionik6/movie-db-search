//
//  MainAssemblerTests.swift
//  MovieDBSearchTests
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import XCTest
import Swinject
@testable import MovieDBSearch

class MainAssemblerTests: XCTestCase {
    
    var sut: MainAssembler!
    
    override func setUp() {
        super.setUp()
        sut = MainAssembler.init()
    }
    
    func testSutResolverIsNotNil() {
        XCTAssertNotNil(sut.resolver)
    }
    
}
