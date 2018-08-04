//
//  SearchViewController+ImagePreheating.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Nuke
import UIKit

extension SearchViewController: UITableViewDataSourcePrefetching {
    
    private var preheater: ImagePreheater { return Nuke.ImagePreheater.init() }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let requests = dataProvider.imageRequests(indexPaths: indexPaths)
        preheater.startPreheating(with: requests)
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        let requests = dataProvider.imageRequests(indexPaths: indexPaths)
        preheater.stopPreheating(with: requests)
    }

}
