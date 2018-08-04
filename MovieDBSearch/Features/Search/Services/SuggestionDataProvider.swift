//
//  SuggestionDataProvider.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit

final class SuggestionDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private let persistence: QueryPersistence
    
    var queries: [Query] { return persistence.retriveQueries() }
    
    init(persistence: QueryPersistence) {
        self.persistence = persistence
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let query = queries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: movieSuggestionCellIdentifier, for: indexPath) as! MovieSuggestionCell
        cell.suggestionLabel.text = query.keyword
        return cell
    }
    
    
}
