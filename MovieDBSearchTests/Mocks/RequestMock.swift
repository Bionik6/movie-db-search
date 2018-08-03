//
//  RequestMock.swift
//  MovieDBSearchTests
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation
@testable import MovieDBSearch


class RequestMock: Request {
    var path: String = "/users"
    var method: HTTPMethod = .get
    var params: RequestParams? = RequestParams.url(["page": 2, "items": 50])
    var headers: [String: String]? = ["Authorization": "Bearer tokenhere"]
}
