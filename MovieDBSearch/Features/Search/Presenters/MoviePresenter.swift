//
//  MovieCellPresenter.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Nuke
import Foundation


/// Presenter for a movie to be displayed
final class MoviePresenter {
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
}


extension MoviePresenter {
    
    
    /// Configure a Movie cell to be presented
    ///
    /// - Parameter cell: The Movie Cell to present based on the movie object
    func configure(with cell: MovieCell) {
        if let url = URL(string: movie.fullPosterPath) {
            let options = ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "poster_placeholder"), transition: .fadeIn(duration: 0.40))
            Nuke.loadImage(with: url, options: options, into: cell.posterimageView)
        }
        cell.overviewLabel.text = movie.overview
        cell.titleLabel.text = movie.name
        cell.releaseDateLabel.attributedText = attributedStringForReleaseDate
    }
    
    private var releaseDateFormated: String {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        guard let date = formater.date(from: movie.releaseDate) else { return movie.releaseDate }
        return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
    }
    
    private var attributedStringForReleaseDate: NSAttributedString {
        let releaseDateStringAttribute = [NSAttributedStringKey.font: Theme.Fonts.avenirNextMedium(size: 14).value,
                                          NSAttributedStringKey.foregroundColor: Theme.Colors.halfWhite.value]
        let attributedText = NSMutableAttributedString(string: "Release Date: ", attributes: releaseDateStringAttribute)
        
        let releaseDateStringValue = [NSAttributedStringKey.font: Theme.Fonts.avenirNextMedium(size: 14).value,
                                          NSAttributedStringKey.foregroundColor: Theme.Colors.white.value]
        attributedText.append(NSAttributedString(string: releaseDateFormated, attributes: releaseDateStringValue))
        
        return attributedText
    }
    
}
