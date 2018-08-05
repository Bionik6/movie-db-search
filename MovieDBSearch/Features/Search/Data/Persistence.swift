//
//  Persistence.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation
import SwiftyJSON


/// Protocol for saving and retrieving suggestion
/// no matter the persistence store used
protocol SuggestionPersistence {
    func saveSuggestion(keyword: String)
    func retriveSuggestions() -> [Suggestion]
}


/// Object for saving suggestion to disk based on
/// NSKeyedArchiver and NSKeyedUnarchiver
class DefaultSuggestionPersistence: SuggestionPersistence {
    
    private lazy var defaultManager = FileManager.default
    
    /// Path of the suggestions file
    private var jsonURL: URL {
        let documentDirectoryUrl = defaultManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectoryUrl.appendingPathComponent("suggestions")
    }
    
    /// Save the query to file if not present yet
    ///
    /// - Parameter keyword: The keyword used to build the query
    func saveSuggestion(keyword: String) {
        let suggestion = Suggestion(keyword: keyword)
        // We check first if we already have a suggestion file
        if var suggestions = NSKeyedUnarchiver.unarchiveObject(withFile: jsonURL.path) as? [Suggestion] {
            let keywords = suggestions.compactMap { $0.keyword }
            // We check if we don't already save a query with
            if !keywords.contains(keyword) {
                suggestions.append(suggestion)
                NSKeyedArchiver.archiveRootObject(suggestions, toFile: jsonURL.path)
            }
        } else { // Otherwise we create a new file with the suggestion within it
            NSKeyedArchiver.archiveRootObject([suggestion], toFile: jsonURL.path)
        }
    }
    
    
    /// Get the list of suggestions
    ///
    /// - Returns: The list of suggestions
    func retriveSuggestions() -> [Suggestion] {
        guard let suggestions = NSKeyedUnarchiver.unarchiveObject(withFile: jsonURL.path) as? [Suggestion] else { return [] }
        return suggestions.sorted(by: { $0.createdDate > $1.createdDate })
    }
    
}
