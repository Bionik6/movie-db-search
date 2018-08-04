//
//  MovieDataProvider+CollectionViewDataSource.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit

extension MovieDataProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shouldShowLoadingCell ? movies.count + 1 : movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingIndexPath(indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: movieLoadingCellIdentifier, for: indexPath) as! MovieLoadingCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath) as! MovieCell
            let presenter = MoviePresenter(movie: movies[indexPath.item])
            presenter.configure(with: cell)
            return cell
        }
    }

}
