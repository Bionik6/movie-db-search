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

/// Presenter for the Empty View based on the state
final class EmptyMoviePresenter {
    
    private var state: EmptyViewState
    
    init(state: EmptyViewState) {
        self.state = state
    }
    
}


extension EmptyMoviePresenter {
    
    // Configure the EmptyView based on the state
    ///
    /// - Parameter cell: The Movie Cell to present based on the movie object
    func configure(with view: EmptyView) {
        switch state {
        case .notSearching:
            view.imageView.image = #imageLiteral(resourceName: "icon_search_video_placeholder")
            view.descriptionLabel.text = "Please use the search box\nabove in order to search your\nmovies"
        case .noMoviesFound:
            view.imageView.image = #imageLiteral(resourceName: "icon_no_results_found")
            view.descriptionLabel.text = "No Movies Found\nPlease use another keyword\nfor searching movies"
        }
        view.descriptionLabel.set(lineHeight: 4.0, alignment: .center)
    }
    
}
