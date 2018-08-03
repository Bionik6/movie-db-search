//
//  Movie.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import SwiftyJSON

struct Movie {
    
    var name: String
    var posterURL: String
    var releaseDate: String
    var overview: String
    
    var fullPosterPath: String {
        return NSString(string: "http://image.tmdb.org/t/p/w185").appendingPathComponent(posterURL)
    }
}


extension Movie {
    init(json: JSON) {
        self.name = json["title"].stringValue
        self.posterURL = json["poster_path"].stringValue
        self.releaseDate = json["release_date"].stringValue
        self.overview = json["overview"].stringValue
    }
}
