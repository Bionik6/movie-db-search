//
//  EmptyMoviePresenter.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation

enum EmptyViewState {
    case notSearching
    case noMoviesFound
}

final class EmptyMoviePresenter {
    
    private var state: EmptyViewState
    
    init(state: EmptyViewState) {
        self.state = state
    }
    
    func configure(view: EmptyView) {
        switch state {
        case .notSearching:
            view.imageView.image = #imageLiteral(resourceName: "icon_search_video_placeholder")
            view.descriptionLabel.text = "Please use the search box\nabove in order to search your\nmovies"
        case .noMoviesFound:
            view.imageView.image = #imageLiteral(resourceName: "icon_no_results_found")
            view.descriptionLabel.text = "No Results\nPlease use another keyword\nfor searching movie"
        }
        view.descriptionLabel.set(lineHeight: 4.0, alignment: .center)
    }
    
}
