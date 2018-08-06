//
//  MovieDataProvider.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Nuke
import Foundation


protocol MovieDataProviderDelegate: AnyObject {
    func movieDataProvider(_ movieDataProvider: MovieDataProvider, didFetchMovies: Bool)
    func movieDataProvider(_ movieDataProvider: MovieDataProvider, isLoadingMovies: Bool)
    func movieDataProvider(_ movieDataProvider: MovieDataProvider, didGetError error: ResponseError)
}


final class MovieDataProvider: NSObject {
    
    // MARK: - Properties
    private let searchService: SearchService
    var isSearching = false
    var movies: [Movie] = []
    var shouldShowLoadingCell = false
    weak var delegate: MovieDataProviderDelegate?
    
    private(set) var searchTerms = ""
    private(set) var currentPage = 1
    
    // MARK: - Initialization
    init(searchService: SearchService) {
        self.searchService = searchService
    }

}


// MARK: - Fetching Movies
extension MovieDataProvider {
    
    /// Fetching movies based on the keywords the user enters
    private func fetchMoviesForSearchTerms() {
        if currentPage == 1 { // Alert the delegate to show the HUD when the current page is 1
            delegate?.movieDataProvider(self, isLoadingMovies: true)
        }
        searchService.fetchMovies(for: searchTerms, page: currentPage) { response in
            // Alert the delegate to hide the HUD when we get a response
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
    
    /// Check if we're loading a given IndexPath
    ///
    /// - Parameter indexPath: The IndexPath to be compared with the total number of movies
    /// - Returns: Boolean telling if we're loading or not
    func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldShowLoadingCell else { return false }
        return indexPath.row == movies.count
    }
    
    /// Fetch the next page if available
    func fetchNextPage() {
        currentPage += 1
        fetchMoviesForSearchTerms()
    }
    
    /// Make a new search and returns the response
    ///
    /// - Parameter keywords: The search terms
    func makeSearch(for keywords: String) {
        // Check first if we make a new search, otherwise just exit
        guard keywords != searchTerms, keywords.count > 0 else { return }
        currentPage = 1
        movies = []
        searchTerms = keywords
        fetchMoviesForSearchTerms()
    }
    
    
    /// Build Nuke image requests for preheating
    ///
    /// - Parameter indexPaths: The next indexpaths to show
    /// - Returns: Array of Nuke Image requests
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
