//
//  SearchViewController+ImagePreheating.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Nuke
import UIKit
import DZNEmptyDataSet


// MARK: - UITableViewDataSourcePrefetching
extension SearchViewController: UITableViewDataSourcePrefetching {
    
    private var preheater: ImagePreheater { return Nuke.ImagePreheater.init() }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let requests = movieDataProvider.imageRequests(indexPaths: indexPaths)
        preheater.startPreheating(with: requests)
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        let requests = movieDataProvider.imageRequests(indexPaths: indexPaths)
        preheater.stopPreheating(with: requests)
    }

}


// MARK: - MovieDataProviderDelegate
extension SearchViewController: MovieDataProviderDelegate, AlertShowable, HudDisplayable {
    
    func movieDataProvider(_ movieDataProvider: MovieDataProvider, didFetchMovies: Bool) {
        if didFetchMovies == false {
            self.isSearching = true
            let message = "Movies based on the keywords you type don't exist, please use another keyword."
            self.showAlert(title: "No Movies found", message: message)
        }
        tableView?.reloadData()
    }
    
    func movieDataProvider(_ movieDataProvider: MovieDataProvider, didGetError error: ResponseError) {
        self.showAlert(title: error.reason.title, message: error.reason.message)
    }
    
    func movieDataProvider(_ movieDataProvider: MovieDataProvider, isLoadingMovies: Bool) {
        let title = "Fetching Movies"
        let message = "Please wait while we're fetching movies based on your keywords"
        isLoadingMovies ? showHUD(title: title, message: message) : hideHUD()
    }
    
}


// MARK: - DZNEmptyDataSetSource
extension SearchViewController: DZNEmptyDataSetSource {
    
    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        let emptyView = EmptyView()
        let state: EmptyViewState = isSearching ? .noMoviesFound : .notSearching
        let presenter = EmptyMoviePresenter(state: state)
        presenter.configure(with: emptyView)
        return emptyView
    }
    
}
