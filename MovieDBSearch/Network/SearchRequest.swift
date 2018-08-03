//
//  SearchRequest.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation

class SearchRequest: Request {
    
    private var apiKey: String? {
        let keyFetcher = APIKeyFetcher()
        return keyFetcher.fetchKey()
    }
    
    var path: String = "search/movie"
    var method: HTTPMethod = .get
    var params: RequestParams? { return .url(["api_key": apiKey ?? "", "query": searchTerms, "page": 1]) }
    
    var headers: [String : String]? = nil
    
    private let searchTerms: String
    
    init(searchTerms: String) {
        self.searchTerms = searchTerms
    }
    
}
