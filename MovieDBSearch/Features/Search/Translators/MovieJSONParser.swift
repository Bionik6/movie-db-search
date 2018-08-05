//
//  JSONParser.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import SwiftyJSON


final class MovieJSONParser: MovieParser {
   
    func parse(data: Data) -> [Movie] {
        guard let jsonData = try? JSON(data: data) else { fatalError("Could not create json with the data provided") }
        return jsonData["results"].arrayValue.map { Movie.init(json: $0) }
    }
    
}
