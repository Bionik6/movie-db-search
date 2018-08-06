//
//  SearchService.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//


/// Object responnsible for making network call, parsing and saving data
final class SearchService {
    
    // MARK: - Properties
    private let parser: PageParser
    private let client: Dispatcher
    private let persistence: SuggestionPersistence
    
    // MARK: - Initialization
    init(client: Dispatcher, parser: PageParser, persistence: SuggestionPersistence) {
        self.parser = parser
        self.client = client
        self.persistence = persistence
    }

}


// MARK: - Movies Fetching
extension SearchService {
    
    /// Fetch movies based on the keyword and save the keyword as suggestion
    ///
    /// - Parameters:
    ///   - searchTerms: The keyword when searching
    ///   - page: The page we want to retrieve moviess
    ///   - completion: The block to be executed after we get a response
    func fetchMovies(for searchTerms: String, page: Int, completion: @escaping (BackendResponse<Page>)->()) {
        let request = SearchRequest(searchTerms: searchTerms, page: page)
        client.execute(request: request) { response in
            switch response {
            case .success(let data):
                if let data = data {
                    let page = self.parser.parse(data: data)
                    executeInMainThread {
                        if page.movies.count > 0 { self.persistence.saveSuggestion(keyword: searchTerms) }
                        completion(.success(page))
                    }
                }
            case .failure(let error):
                executeInMainThread { completion(.failure(error)) }
            }
        }
    }
    
}
