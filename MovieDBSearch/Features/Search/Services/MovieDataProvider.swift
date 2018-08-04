//
//  MovieDataProvider.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit
import Nuke


protocol MovieDataProviderDelegate: AnyObject {
    func movieDataProvider(_ movieDataProvider: MovieDataProvider, didFetchMovies: Bool)
    func movieDataProvider(_ movieDataProvider: MovieDataProvider, isLoadingMovies: Bool)
    func movieDataProvider(_ movieDataProvider: MovieDataProvider, didGetError: ResponseError)
}


final class MovieDataProvider: NSObject {
    
    var isSearching = false
    var movies: [Movie] = []
    var shouldShowLoadingCell = false
    weak var delegate: MovieDataProviderDelegate?
    
    private var searchTerms = ""
    private var currentPage = 1
    
    private lazy var factory: SearchFactory = {
        let client = mainAssembler?.resolver.resolve(Dispatcher.self)!
        let parser = mainAssembler?.resolver.resolve(PageParser.self)!
        return SearchFactory(client: client!, parser: parser!)
    }()
    
    func fetchMoviesForSearchTerms() {
        if currentPage == 1 {
            delegate?.movieDataProvider(self, isLoadingMovies: true)
        }
        factory.fetchMovies(for: searchTerms, page: currentPage) { response in
            self.delegate?.movieDataProvider(self, isLoadingMovies: false)
            switch response {
            case .success(let page):
                self.shouldShowLoadingCell = page.currentPage < page.totalPages
                self.movies.append(contentsOf: page.movies)
                self.delegate?.movieDataProvider(self, didFetchMovies: page.movies.count > 0 ? true : false)
            case .failure(let error):
                self.delegate?.movieDataProvider(self, didGetError: error)
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
    
    func imageRequests(indexPaths: [IndexPath]) -> [Nuke.ImageRequest] {
        let movies: [Movie] = indexPaths.compactMap { indexPath in
            guard indexPath.item < self.movies.count else { return nil }
            return self.movies[indexPath.row]
        }
        let imageUrls = movies.compactMap { $0.fullPosterPath }
        let requests = imageUrls.compactMap { URL.init(string: $0) }.compactMap { Nuke.ImageRequest.init(url: $0) }
        return requests
    }
}
