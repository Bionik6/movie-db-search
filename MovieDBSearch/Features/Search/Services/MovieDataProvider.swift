//
//  MovieDataProvider.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit
import Swinject


final class MovieDataProvider: NSObject {
    
    var isSearching = false
    var movies: [Movie] = []
    var didFinishFetchingData: ()->() = {  }
    var shouldShowLoadingCell = false
    
    private var searchTerms = ""
    private var currentPage = 1
    
    private lazy var factory: SearchFactory = {
        let client = mainAssembler?.resolver.resolve(Dispatcher.self)!
        let parser = mainAssembler?.resolver.resolve(PageParser.self)!
        return SearchFactory(client: client!, parser: parser!)
    }()
    
    func fetchMoviesForSearchTerms() {
        factory.fetchMovies(for: searchTerms, page: currentPage) { response in
            switch response {
            case .success(let page):
                self.shouldShowLoadingCell = page.currentPage < page.totalPages
                self.movies.append(contentsOf: page.movies)
                self.didFinishFetchingData()
            default: break
            }
        }
    }
    
    func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldShowLoadingCell else { return false }
        return indexPath.item == self.movies.count
    }
    
    func fetchNextPage() {
        currentPage += 1
        fetchMoviesForSearchTerms()
    }
    
    func makeSearch(for keywords: String) {
        guard keywords != searchTerms else { return }
        currentPage = 1
        movies = []
        searchTerms = keywords
        fetchMoviesForSearchTerms()
    }
}
