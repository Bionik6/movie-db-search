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

final class SearchViewController: UIViewController {
    
    // MARK:- Properties
    private(set) lazy var searchView = SearchView(frame: UIScreen.main.bounds)
    private(set) lazy var searchTextField = searchView.searchTextField
    private(set) lazy var tableView = searchView.tableView
    private(set) lazy var suggestionTableView = searchView.suggestionTableView
    private lazy var cancelButton = searchView.cancelButton
    fileprivate var isSearching = false
    private let disposeBag = DisposeBag()
    
    lazy var dataProvider: MovieDataProvider = {
        let provider = MovieDataProvider.init()
        return provider
    }()
    
    private lazy var suggestionDataProvider: SuggestionDataProvider = {
        let persistence = mainAssembler?.resolver.resolve(QueryPersistence.self)!
        let provider = SuggestionDataProvider(persistence: persistence!)
        return provider
    }()
    
    // MARK:- View Controller Lifecycle
    override func loadView() { self.view = searchView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRXObservers()
        setupDataProviders()
        setupMainTableViewDataSourceAndDelegate()
        setupSuggestionTableViewDataSourceAndDelegate()
        searchView.hideSuggestionTableView()
    }
    
}


// MARK: - View Setup
extension SearchViewController {
    
    fileprivate func setupView() {
        title = "MOVIE DB Search"
    }
    
    fileprivate func setupMainTableViewDataSourceAndDelegate() {
        tableView?.dataSource = dataProvider
        tableView?.delegate = dataProvider
        tableView?.emptyDataSetSource = self
        if #available(iOS 10.0, *) { tableView?.prefetchDataSource = self }
    }
    
    fileprivate func setupSuggestionTableViewDataSourceAndDelegate() {
        suggestionTableView?.dataSource = suggestionDataProvider
        suggestionTableView?.delegate = suggestionDataProvider
    }
    
    fileprivate func setupRXObservers() {
        searchTextField?.rx.controlEvent([.editingDidBegin]).subscribe(onNext: { _ in
            self.suggestionDataProvider.queries.count > 0
                ? self.searchView.showSuggestionTableView()
                : self.searchView.hideSuggestionTableView()
        }).disposed(by: disposeBag)
        
        searchTextField?.rx.controlEvent([.editingDidEndOnExit]).subscribe(onNext: { _ in
            self.makeSearch()
        }).disposed(by: disposeBag)
        
        searchView.topSearchButton.rx.tap.asObservable().subscribe(onNext: { _ in
            self.makeSearch()
        }).disposed(by: disposeBag)
    }
    
    private func makeSearch() {
        let keywords = self.searchTextField?.text!
        searchView.hideSuggestionTableView()
        dataProvider.makeSearch(for: keywords!)
        self.searchTextField?.resignFirstResponder()
    }
    
    fileprivate func setupDataProviders() {
        dataProvider.delegate = self
        suggestionDataProvider.didSelectSuggestion = { [weak self] suggestion in
            self?.searchView.hideSuggestionTableView()
            self?.dataProvider.makeSearch(for: suggestion.keyword)
            self?.searchTextField?.text = nil
            self?.searchTextField?.resignFirstResponder()
        }
    }
    
}


extension SearchViewController: MovieDataProviderDelegate, AlertShowable, HudDisplayable {
    
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
    
}


extension SearchViewController: DZNEmptyDataSetSource {
    
    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        let emptyView = EmptyView()
        let state: EmptyViewState = isSearching ? .noMoviesFound : .notSearching
        let presenter = EmptyMoviePresenter(state: state)
        presenter.configure(with: emptyView)
        return emptyView
    }
    
}
