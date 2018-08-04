//
//  SearchRequest.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation

class SearchRequest: Request {
    
    private var currentPage: Int
    private let searchTerms: String
    
    private var apiKey: String? {
        let keyFetcher = APIKeyFetcher()
        return keyFetcher.fetchKey()
    }
    
    var path: String = "search/movie"
    var method: HTTPMethod = .get
    var params: RequestParams? { return .url(["api_key": apiKey ?? "", "query": searchTerms, "page": currentPage]) }
    var headers: [String : String]? = nil
    
    
    init(searchTerms: String, page: Int) {
        self.searchTerms = searchTerms
        self.currentPage = page
    }
    
}
