//
//  BackendResponse.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation

enum ResponseError: Error {
    case noInternetConnection
}


enum BackendResponse<T> {
    case success(T)
    case failure(ResponseError)
}
