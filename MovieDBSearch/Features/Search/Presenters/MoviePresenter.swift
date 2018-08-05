//
//  MovieCellPresenter.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation
import Nuke


final class MoviePresenter {
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
}

extension MoviePresenter {
    
    func configure(with cell: MovieCell) {
        if let url = URL(string: movie.fullPosterPath) {
            let options = ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "poster_placeholder"), transition: ImageLoadingOptions.Transition.fadeIn(duration: 0.40))
            Nuke.loadImage(with: url, options: options, into: cell.posterimageView)
        }
        cell.overviewLabel.text = movie.overview
        cell.titleLabel.text = movie.name
        cell.releaseDateLabel.text = movie.releaseDate
    }
}
