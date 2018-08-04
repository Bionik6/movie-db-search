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


class JSONQueryPersistence: QueryPersistence {
    
    private lazy var defaultManager = FileManager.default
    
    var jsonURL: URL {
        let documentDirectoryUrl = defaultManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectoryUrl.appendingPathComponent("Queries.json")
    }
    
    func saveQuery(keyword: String) {
        let query = Query(keyword: keyword, createdTimestamp: Date().timeIntervalSince1970)
        if fileExists() {
            var savedQueries = retriveQueries()
            savedQueries.append(query)
            let json = JSON(arrayLiteral: savedQueries)
            guard let data = (json.object as? String)?.data(using: .utf8) else { return }
            do {
                try data.write(to: jsonURL)
            } catch { log.error(error) }
        } else {
            let json = JSON(arrayLiteral: [query])
            guard let data = (json.object as? String)?.data(using: .utf8) else { return }
            do {
                try data.write(to: jsonURL)
            } catch { log.error(error) }
        }
        
    }
    
    func retriveQueries() -> [Query] {
        do {
            let data = try Data(contentsOf: jsonURL)
            let json = try JSON(data: data)
            let queries = json.arrayValue.map { Query.init(json: $0) }
            log.debug(queries)
        } catch { log.error(error) }
        return []
    }
    
    func fileExists() -> Bool {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent("Queries.json") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            return fileManager.fileExists(atPath: filePath)
        } else {
            return false
        }
    }
    
}
