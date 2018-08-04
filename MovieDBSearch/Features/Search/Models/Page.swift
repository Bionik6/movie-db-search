//
//  Page.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import SwiftyJSON

struct Page {
    
    var currentPage: Int
    var totalPages: Int
    var totalResults: Int
    var movies: [Movie]
    
}


extension Page {
    
    init(json: JSON) {
        self.currentPage = json["page"].intValue
        self.totalPages = json["total_pages"].intValue
        self.totalResults = json["total_results"].intValue
        self.movies = json["results"].arrayValue.map { Movie.init(json: $0) }
    }
    
}
