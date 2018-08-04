//
//  MovieDataProvider.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit
import Swinject


final class MovieDataProvider: NSObject, UICollectionViewDataSource {
    
    var isSearching = false
    private var movies: [Movie] = []
    var didFinishFetchingData: ()->() = {  }
    private var currentPage = 1
    var shouldShowLoadingCell = false
    private var searchTerms = ""
    
    private lazy var factory: SearchFactory = {
        let client = mainAssembler?.resolver.resolve(Dispatcher.self)!
        let parser = mainAssembler?.resolver.resolve(PageParser.self)!
        return SearchFactory(client: client!, parser: parser!)
    }()
    
    func fetchMovies() {
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shouldShowLoadingCell ? movies.count + 1 : movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isLoadingIndexPath(indexPath) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieLoadingCellIdentifier, for: indexPath) as! MovieLoadingCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCellIdentifier, for: indexPath) as! MovieCell
            let presenter = MoviePresenter(movie: movies[indexPath.item])
            presenter.configure(cell: cell)
            return cell
        }
    }
    
    func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldShowLoadingCell else { return false }
        return indexPath.item == self.movies.count
    }
    
    func fetchNextPage() {
        currentPage += 1
        fetchMovies()
    }
    
    func makeSearch(for keywords: String) {
        guard keywords != searchTerms else { return }
        currentPage = 1
        movies = []
        searchTerms = keywords
        fetchMovies()
    }
}
