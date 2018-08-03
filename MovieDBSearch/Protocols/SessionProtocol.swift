//
//  SessionProtocol.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation


protocol SessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
}

extension URLSession: SessionProtocol { }
