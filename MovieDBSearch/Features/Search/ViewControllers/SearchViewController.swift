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
    
    private(set) lazy var searchView = SearchView(frame: UIScreen.main.bounds)
    private(set) lazy var searchTextField = searchView.searchTextField
    private(set) lazy var collectionView = searchView.collectionView
        
    private let disposeBag = DisposeBag()
    private lazy var dataProvider: MovieDataProvider = {
        let provider = mainAssembler?.resolver.resolve(MovieDataProvider.self)
        return provider!
    }()
    
    // MARK:- View Controller Lifecycle
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRXObservers()
        setupCollectionView()
        dataProvider.fetchMovies(for: "dsfd") { response in
            
        }
    }
    
}

extension SearchViewController {
    
    fileprivate func setupView() {
        title = "MOVIE DB Search"
    }
    
    fileprivate func setupCollectionView() {
        collectionView?.dataSource = dataProvider
    }
    
    fileprivate func setupRXObservers() {
        searchTextField?.rx.text.orEmpty.asObservable().subscribe(onNext: { text in
            text.count > 0 ? self.searchView.showTopSearchButton() : self.searchView.hideTopSearchButton()
        }).disposed(by: disposeBag)
    }
    
}



