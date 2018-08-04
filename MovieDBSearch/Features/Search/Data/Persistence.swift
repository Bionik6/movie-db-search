//
//  Persistence.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol QueryPersistence {
    func saveQuery(keyword: String)
    func retriveQueries() -> [Query]
}


class DefaultQueryPersistence: QueryPersistence {
    
    private lazy var defaultManager = FileManager.default
    
    var jsonURL: URL {
        let documentDirectoryUrl = defaultManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectoryUrl.appendingPathComponent("Queries")
    }
    
    func saveQuery(keyword: String) {
        let query = Query(keyword: keyword)
        if var queries = NSKeyedUnarchiver.unarchiveObject(withFile: jsonURL.path) as? [Query] {
            let keywords = queries.compactMap { $0.keyword }
            if !keywords.contains(keyword) {
                queries.append(query)
                NSKeyedArchiver.archiveRootObject(queries, toFile: jsonURL.path)
            }
        } else {
            NSKeyedArchiver.archiveRootObject([query], toFile: jsonURL.path)
        }
    }
    
    func retriveQueries() -> [Query] {
        guard let queries = NSKeyedUnarchiver.unarchiveObject(withFile: jsonURL.path) as? [Query] else { return [] }
        return queries
    }
    
}
