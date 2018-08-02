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
    
    private lazy var searchView = SearchView(frame: UIScreen.main.bounds)
    private lazy var searchTextField = searchView.searchTextField
    private let disposeBag = DisposeBag()
    
    // MARK:- View Controller Lifecycle
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupRXObservers()
    }
    
}


