//
//  SearchFactory.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation

final class SearchFactory {
    
    fileprivate let parser: PageParser
    fileprivate let client: Dispatcher
    fileprivate let persistence: QueryPersistence
    
    init(client: Dispatcher, parser: PageParser, persistence: QueryPersistence) {
        self.parser = parser
        self.client = client
        self.persistence = persistence
    }
    
    func fetchMovies(for searchTerms: String, page: Int, completion: @escaping (BackendResponse<Page>)->()) {
        let request = SearchRequest(searchTerms: searchTerms, page: page)
        client.execute(request: request) { response in
            switch response {
            case .success(let data):
                if let data = data {
                    let page = self.parser.parse(data: data)
                    OperationQueue.main.addOperation {
                        if page.movies.count > 0 {
                            self.persistence.saveQuery(keyword: searchTerms)
                        }
                        log.debug(self.persistence.retriveQueries())
                        completion(.success(page))
                    }
                }
            case .failure(let error):
                OperationQueue.main.addOperation { completion(.failure(error)) }
            }
        }
    }
    
}
