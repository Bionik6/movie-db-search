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
    
    private lazy var factory: SearchFactory = {
        let client = mainAssembler?.resolver.resolve(Dispatcher.self)!
        let parser = mainAssembler?.resolver.resolve(MovieParser.self)!
        return SearchFactory(client: client!, parser: parser!)
    }()
    
    var searchTerms: String = "" {
        didSet {
            factory.fetchMovies(for: searchTerms, page: currentPage) { response in
                switch response {
                case .success(let movies):
                    self.movies = movies.sorted(by: { $0.releaseDate > $1.releaseDate })
                    self.didFinishFetchingData()
                default: break
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieCell
        let presenter = MoviePresenter(movie: movies[indexPath.item])
        presenter.configure(cell: cell)
        return cell
    }
}
