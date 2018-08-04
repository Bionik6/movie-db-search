//
//  Query.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import SwiftyJSON
import Foundation

struct Query {
    var keyword: String
    var createdTimestamp: TimeInterval
}


extension Query {
    
    init(json: JSON) {
        self.keyword = json["keyword"].stringValue
        self.createdTimestamp = json["createdTimestamp"].doubleValue
    }
    
}
