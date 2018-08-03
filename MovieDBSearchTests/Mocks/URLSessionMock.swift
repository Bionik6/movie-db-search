//
//  URLSessionMock.swift
//  MovieDBSearchTests
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation
@testable import MovieDBSearch


final class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}


final class URLSessionMock: SessionProtocol {
    
    var isDataTaskCalled = false
    var data: Data?
    var error: Error?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        return URLSessionDataTaskMock { completionHandler(data, nil, error) }
    }
}
