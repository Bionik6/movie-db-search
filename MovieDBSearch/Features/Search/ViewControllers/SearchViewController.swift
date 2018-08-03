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

let cellIdentifier = "Cell"

final class SearchViewController: UIViewController {
    
    private(set) lazy var searchView = SearchView(frame: UIScreen.main.bounds)
    private(set) lazy var searchTextField = searchView.searchTextField
    private(set) lazy var collectionView = searchView.collectionView
    
    private let disposeBag = DisposeBag()
    private lazy var dataProvider: MovieDataProvider = {
        let provider = MovieDataProvider.init()
        return provider
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
    }
    
}

extension SearchViewController {
    
    fileprivate func setupView() {
        title = "MOVIE DB Search"
    }
    
    fileprivate func setupCollectionView() {
        collectionView?.dataSource = dataProvider
        collectionView?.delegate = self
        collectionView?.backgroundColor = .clear
        let nibCell = UINib(nibName: "MovieCell", bundle: nil)
        collectionView?.register(nibCell, forCellWithReuseIdentifier: cellIdentifier)
        dataProvider.didFinishFetchingData = {
            self.collectionView!.reloadData()
        }
    }
    
    fileprivate func setupRXObservers() {
        searchTextField?.rx.text.orEmpty.asObservable().subscribe(onNext: { text in
            text.count > 0 ? self.searchView.showTopSearchButton() : self.searchView.hideTopSearchButton()
        }).disposed(by: disposeBag)
        searchTextField?.rx.controlEvent([.editingDidEndOnExit]).subscribe(onNext: { _ in
            self.dataProvider.searchTerms = (self.searchTextField?.text!)!
        }).disposed(by: disposeBag)
    }
    
}
