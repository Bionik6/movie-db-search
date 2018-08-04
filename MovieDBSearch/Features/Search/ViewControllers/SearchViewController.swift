//
//  SearchViewController.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DZNEmptyDataSet

let movieCellIdentifier = "MovieCell"
let movieLoadingCellIdentifier = "MovieLoadingCell"

final class SearchViewController: UIViewController {
    
    // MARK:- Properties
    private(set) lazy var searchView = SearchView(frame: UIScreen.main.bounds)
    private(set) lazy var searchTextField = searchView.searchTextField
    private(set) lazy var tableView = searchView.tableView
    fileprivate var isSearching = false
    
    private let disposeBag = DisposeBag()
    private lazy var dataProvider: MovieDataProvider = {
        let provider = MovieDataProvider.init()
        return provider
    }()
    
    // MARK:- View Controller Lifecycle
    override func loadView() { self.view = searchView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRXObservers()
        setupTableView()
        setupDataProvider()
    }
    
}

// MARK: - View Setup
extension SearchViewController {
    
    fileprivate func setupView() {
        title = "MOVIE DB Search"
    }
    
    fileprivate func setupTableView() {
        tableView?.estimatedRowHeight = 120
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.dataSource = dataProvider
        tableView?.delegate = dataProvider
        tableView?.backgroundColor = .clear
        tableView?.emptyDataSetSource = self
        let movieNibCell = UINib(nibName: "MovieCell", bundle: nil)
        let loadingMovieNibCell = UINib(nibName: "MovieLoadingCell", bundle: nil)
        tableView?.register(movieNibCell, forCellReuseIdentifier: movieCellIdentifier)
        tableView?.register(loadingMovieNibCell, forCellReuseIdentifier: movieLoadingCellIdentifier)
        
    }
    
    fileprivate func setupRXObservers() {
        searchTextField?.rx.text.orEmpty.asObservable().subscribe(onNext: { text in
            text.count > 0 ? self.searchView.showTopSearchButton() : self.searchView.hideTopSearchButton()
        }).disposed(by: disposeBag)
        searchTextField?.rx.controlEvent([.editingDidEndOnExit]).subscribe(onNext: { _ in
            let keywords = self.searchTextField?.text!
            self.dataProvider.makeSearch(for: keywords!)
        }).disposed(by: disposeBag)
        searchView.bottomSearchButton.rx.tap.asObservable().subscribe(onNext: { _ in
            self.searchTextField?.becomeFirstResponder()
        }).disposed(by: disposeBag)
    }
    
    fileprivate func setupDataProvider() {
        dataProvider.delegate = self
    }
    
}


extension SearchViewController: MovieDataProviderDelegate, DZNEmptyDataSetSource, AlertShowable, HudDisplayable {
    
    func movieDataProvider(_ movieDataProvider: MovieDataProvider, didFetchMovies: Bool) {
        if didFetchMovies == false {
            self.isSearching = true
            let message = "Movies based on the keywords you type don't exist, please use another keyword."
            self.showAlert(title: "No Movies found", message: message)
        }
        tableView?.reloadData()
    }
    
    func movieDataProvider(_ movieDataProvider: MovieDataProvider, didGetError: ResponseError) {
        
    }
    
    func movieDataProvider(_ movieDataProvider: MovieDataProvider, isLoadingMovies: Bool) {
        let title = "Fetching Movies"
        let message = "Please wait while we're fetching movies based on your keywords"
        isLoadingMovies ? showHUD(title: title, message: message) : hideHUD()
    }
    
    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        let emptyView = EmptyView()
        let state: EmptyViewState = isSearching ? .noMoviesFound : .notSearching
        let presenter = EmptyMoviePresenter(state: state)
        presenter.configure(view: emptyView)
        return emptyView
    }
}
