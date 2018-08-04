//
//  SearchView.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit

let movieCellIdentifier = "MovieCell"
let movieLoadingCellIdentifier = "MovieLoadingCell"
let movieSuggestionCellIdentifier = "MovieSuggestionCell"

class SearchView: BaseView, XibInitializable {
    
    @IBOutlet private(set) weak var topSearchButton: GradientButton!
    @IBOutlet private(set) weak var searchTextField: CustomTextField!
    @IBOutlet private(set) weak var searchTextFieldTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private(set) weak var bottomSearchButton: GradientButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var suggestionTableView: UITableView!
    
    override func initializeView() { setupXib() }
    
    override func setupView() {
        hideTopSearchButton()
        setupMainTableView()
        setupSuggestionTableView()
    }
    
    private func setupMainTableView() {
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = .clear
        let movieNibCell = UINib(nibName: "MovieCell", bundle: nil)
        let loadingMovieNibCell = UINib(nibName: "MovieLoadingCell", bundle: nil)
        tableView.register(movieNibCell, forCellReuseIdentifier: movieCellIdentifier)
        tableView.register(loadingMovieNibCell, forCellReuseIdentifier: movieLoadingCellIdentifier)
    }
    
    private func setupSuggestionTableView() {
        suggestionTableView.rowHeight = 50
        let movieSuggestionNibCell = UINib(nibName: "MovieSuggestionCell", bundle: nil)
        suggestionTableView.register(movieSuggestionNibCell, forCellReuseIdentifier: movieSuggestionCellIdentifier)
        suggestionTableView.tableFooterView = UIView()
    }
    
    func showTopSearchButton() {
        searchTextFieldTrailingConstraint.constant = 108
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.topSearchButton.transform = CGAffineTransform.identity
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func hideTopSearchButton() {
        searchTextFieldTrailingConstraint.constant = 8
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseIn,
                       animations: {
                        self.topSearchButton.transform = CGAffineTransform(scaleX: 0, y: 0)
                        self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func showSuggestionTableView() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.suggestionTableView.alpha = 1.0
            self.suggestionTableView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func hideSuggestionTableView() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.suggestionTableView.alpha = 0.0
            self.suggestionTableView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }, completion: nil)
    }
    
}
