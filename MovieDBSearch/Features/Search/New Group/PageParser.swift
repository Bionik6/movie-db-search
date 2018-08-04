//
//  PageParser.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation

protocol PageParser {
    func parse(data: Data) -> [Movie]
}
