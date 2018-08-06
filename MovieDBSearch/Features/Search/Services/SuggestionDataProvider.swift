//
//  SuggestionDataProvider.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit


final class SuggestionDataProvider: NSObject {
    
    // MARK: - Properties
    private let persistence: SuggestionPersistence
    var didSelectSuggestion: (Suggestion)->() = { _ in }
    var suggestions: [Suggestion] { return persistence.retriveSuggestions() }
    
    // MARK: - Initialization
    init(persistence: SuggestionPersistence) {
        self.persistence = persistence
    }
    
}


// MARK: - UITableViewDataSource
extension SuggestionDataProvider: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let suggestion = suggestions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: movieSuggestionCellIdentifier, for: indexPath) as! MovieSuggestionCell
        cell.suggestionLabel.text = suggestion.keyword
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectSuggestion(suggestions[indexPath.row])
    }
    
}
