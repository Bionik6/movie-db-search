//
//  Parser.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation

protocol MovieParser {
    func parse(data: Data) -> [Movie]
}

protocol Parser {
    associatedtype T
    
    func parse(data: Data) -> T
}
