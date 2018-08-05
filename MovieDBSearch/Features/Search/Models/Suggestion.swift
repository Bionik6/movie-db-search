//
//  Query.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import SwiftyJSON
import Foundation

class Suggestion: NSObject, NSCoding {
    
    var keyword: String
    var createdDate: String
    
    init(keyword: String, createdDate: String = Date().toString) {
        self.keyword = keyword
        self.createdDate = createdDate
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.keyword, forKey: "keyword")
        aCoder.encode(self.createdDate, forKey: "createdDate")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let keyword = aDecoder.decodeObject(forKey: "keyword") as? String,
            let createdDate = aDecoder.decodeObject(forKey: "createdDate") as? String else { return nil }
        self.init(keyword: keyword, createdDate: createdDate)
    }
}


extension Date {
    
    var toString: String {
        let format = DateFormatter()
        format.dateFormat="yyyy-MM-dd-HH-mm-ss-SSSS"
        return format.string(from: self)
    }
    
}
