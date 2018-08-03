//
//  DispatcherMock.swift
//  MovieDBSearchTests
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation
@testable import MovieDBSearch


class DispatcherMock: Dispatcher {
    
    let data = Data(bytes: [0, 1, 0, 1])
    var error: Error?
    
    var baseURL: NSString = "fake/url"
    var session: SessionProtocol
    
    required init(session: SessionProtocol) {
        self.session = URLSessionMock()
    }
    
    func execute(request: Request, completion: @escaping (BackendResponse<Data?>) -> ()) {
        completion(BackendResponse.success(data))
    }
    
}
