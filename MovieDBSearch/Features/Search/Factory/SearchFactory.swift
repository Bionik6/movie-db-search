//
//  SearchFactory.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation

final class SearchFactory {
    
    fileprivate let parser: Parser
    fileprivate let client: Dispatcher
    
    init(client: Dispatcher, parser: Parser) {
        self.parser = parser
        self.client = client
    }
    
    func fetchMovies(for searchTerms: String, completion: @escaping (BackendResponse<[Movie]>)->()) {
        let request = SearchRequest(searchTerms: searchTerms)
        client.execute(request: request) { response in
            switch response {
            case .success(let data):
                if let data = data {
                    let movies = self.parser.parse(data: data)
                    OperationQueue.main.addOperation { completion(.success(movies)) }
                }
            case .failure(let error): print(error)
            }
        }
    }
    
}
