//
//  SearchView.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit
import RxSwift

let movieCellIdentifier = "MovieCell"
let movieLoadingCellIdentifier = "MovieLoadingCell"
let movieSuggestionCellIdentifier = "MovieSuggestionCell"


class SearchView: BaseView, XibInitializable {
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet private(set) weak var topSearchButton: GradientButton!
    @IBOutlet private(set) weak var searchTextField: CustomTextField!
    @IBOutlet private(set) weak var searchTextFieldTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private(set) weak var bottomSearchButton: GradientButton!
    @IBOutlet private(set) weak var tableView: UITableView!
    @IBOutlet private(set) weak var suggestionTableView: UITableView!
    @IBOutlet private(set) weak var suggestionTableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private(set) weak var cancelButton: UIButton!
    
    override func initializeView() { setupXib() }
    
    override func setupView() {
        hideTopSearchButton()
        setupMainTableView()
        setupRXObservers()
        setupSuggestionTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let targetFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardHeight: CGFloat = isIphoneXOrBigger ? -targetFrame.height + 34 : -targetFrame.height
        suggestionTableViewBottomConstraint.constant = keyboardHeight
        self.makeBasicAnimation { self.layoutIfNeeded() }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        suggestionTableViewBottomConstraint.constant = 0
        self.makeBasicAnimation { self.layoutIfNeeded() }
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
        makeBasicAnimation {
            self.topSearchButton.transform = CGAffineTransform.identity
            self.layoutIfNeeded()
        }
    }
    
    func hideTopSearchButton() {
        searchTextFieldTrailingConstraint.constant = 8
        makeBasicAnimation {
            self.topSearchButton.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.layoutIfNeeded()
        }
    }
    
    func showSuggestionTableView() {
        suggestionTableView.reloadData()
        makeBasicAnimation {
            self.suggestionTableView.alpha = 1.0
            self.suggestionTableView.transform = CGAffineTransform.identity
        }
    }
    
    func hideSuggestionTableView() {
        makeBasicAnimation {
            self.suggestionTableView.alpha = 0.0
            self.suggestionTableView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
    }
    
    func showCancelButton() {
        makeBasicAnimation {
            self.cancelButton.alpha = 1.0
            self.cancelButton.transform = CGAffineTransform.identity
        }
    }
    
    func hideCancelButton() {
        makeBasicAnimation {
            self.cancelButton.alpha = 0.0
            self.cancelButton.transform = CGAffineTransform.identity
        }
    }
    
    private func makeBasicAnimation(animations: @escaping () -> ()) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseIn,
                       animations: animations,
                       completion: nil)
    }
    
    
    fileprivate func setupRXObservers() {
        searchTextField?.rx.text.orEmpty.asObservable().subscribe(onNext: { text in
            text.count > 0 ? self.showTopSearchButton() : self.hideTopSearchButton()
            text.count > 0 ? self.showCancelButton() : self.hideCancelButton()
            text.count > 0 ? self.showSuggestionTableView(): self.hideSuggestionTableView()
        }).disposed(by: disposeBag)
        
        bottomSearchButton.rx.tap.asObservable().subscribe(onNext: { _ in
            self.searchTextField?.becomeFirstResponder()
        }).disposed(by: disposeBag)
        
        cancelButton?.rx.tap.asObservable().subscribe(onNext: { _ in
            self.searchTextField?.text = nil
            self.searchTextField?.resignFirstResponder()
            self.hideSuggestionTableView()
            self.hideTopSearchButton()
            self.hideCancelButton()
        }).disposed(by: disposeBag)
    }
    
}
