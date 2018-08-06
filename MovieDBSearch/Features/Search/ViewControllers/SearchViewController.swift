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

final class SearchViewController: UIViewController {
    
    // MARK: - Properties
    private(set) lazy var searchView = SearchView(frame: UIScreen.main.bounds)
    private(set) lazy var searchTextField = searchView.searchTextField
    private(set) lazy var tableView = searchView.tableView
    private(set) lazy var suggestionTableView = searchView.suggestionTableView
    private lazy var cancelButton = searchView.cancelButton
    private let disposeBag = DisposeBag()
    
    var isSearching = false
    
    lazy var movieDataProvider: MovieDataProvider = {
        let factory = mainAssembler?.resolver.resolve(SearchFactory.self)!
        let provider = MovieDataProvider.init(factory: factory!)
        return provider
    }()
    
    private lazy var suggestionDataProvider: SuggestionDataProvider = {
        let persistence = mainAssembler?.resolver.resolve(SuggestionPersistence.self)!
        let provider = SuggestionDataProvider(persistence: persistence!)
        return provider
    }()
    
    // MARK: - View Controller Lifecycle
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
        tableView?.dataSource = movieDataProvider
        tableView?.delegate = movieDataProvider
        tableView?.emptyDataSetSource = self
        if #available(iOS 10.0, *) { tableView?.prefetchDataSource = self }
    }
    
    fileprivate func setupSuggestionTableViewDataSourceAndDelegate() {
        suggestionTableView?.dataSource = suggestionDataProvider
        suggestionTableView?.delegate = suggestionDataProvider
    }
    
    fileprivate func setupRXObservers() {
        searchTextField?.rx.controlEvent([.editingDidBegin]).subscribe(onNext: { _ in
            self.suggestionDataProvider.suggestions.count > 0
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
        movieDataProvider.makeSearch(for: keywords!)
        self.searchTextField?.resignFirstResponder()
    }
    
    fileprivate func setupDataProviders() {
        movieDataProvider.delegate = self
        suggestionDataProvider.didSelectSuggestion = { [weak self] suggestion in
            self?.searchView.hideSuggestionTableView()
            self?.movieDataProvider.makeSearch(for: suggestion.keyword)
            self?.searchTextField?.text = nil
            self?.searchTextField?.resignFirstResponder()
        }
    }
    
}
