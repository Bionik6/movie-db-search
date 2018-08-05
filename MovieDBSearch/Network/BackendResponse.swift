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
    case unknown(message: String)
    
    var reason: (title: String, message: String) {
        switch self {
        case .noInternetConnection:
            return ("No Internet Connection", "You have no internet connection. Please make sure you're connected to internet")
        case .unknown(let message):
            return ("Can't load movies", message)
        }
    }
    
}


enum BackendResponse<T> {
    case success(T)
    case failure(ResponseError)
}
