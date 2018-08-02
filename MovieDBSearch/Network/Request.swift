
//
//  Request.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/1/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

protocol Request {
    
    var path: String { get }
    var method: HTTPMethod { get }
    var params: RequestParams? { get }
    var headers: [String: String]? { get }
    
}
