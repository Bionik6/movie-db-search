//
//  SearchView.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit

class SearchView: BaseView, XibInitializable {
    
    @IBOutlet private(set) weak var topSearchButton: GradientButton!
    @IBOutlet private(set) weak var searchTextField: CustomTextField!
    @IBOutlet private(set) weak var searchTextFieldTrailingConstraint: NSLayoutConstraint!
    
    override func initializeView() { setupXib() }
    
    override func setupView() {
        hideTopSearchButton()
    }
    
    private func showTopSearchButton() {
        searchTextFieldTrailingConstraint.constant = 110
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.topSearchButton.transform = CGAffineTransform.identity
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func hideTopSearchButton() {
        searchTextFieldTrailingConstraint.constant = 16
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.topSearchButton.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
}
