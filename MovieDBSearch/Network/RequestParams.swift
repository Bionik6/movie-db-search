//
//  RequestParams.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/1/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation

enum RequestParams: Equatable {
    
    case body([String:Any])
    case url([String:Any])
    

    static func == (lhs: RequestParams, rhs: RequestParams) -> Bool {
        switch (lhs, rhs) {
        case (.body(let lhsJSON), .body(let rhsJSON)):
            let lhsDictionary = NSDictionary.init(dictionary: lhsJSON)
            return lhsDictionary.isEqual(to: rhsJSON)
        case(.url(let lhsJSON), .url(let rhsJSON)):
            let lhsDictionary = NSDictionary.init(dictionary: lhsJSON)
            return lhsDictionary.isEqual(to: rhsJSON)
        default: return false
        }
    }
    
}
