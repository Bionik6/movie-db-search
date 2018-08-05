//
//  APIKeyFetcher.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation


/// Main object responsible of fetching the API Key since
/// it's stored in a plist file that should normally be in our .gitignore
/// or fetched from a secure (https) web server and stored to the keychain
final class APIKeyFetcher {
    
    
    /// Fetch the API Key
    ///
    /// - Returns: The API Key or return nil
    func fetchKey() -> String? {
        guard let path = Bundle.main.path(forResource: "APIKey", ofType: "plist") else { return nil }
        let dictionary = NSDictionary(contentsOfFile: path)
        return dictionary?.value(forKey: "api_key") as? String
    }
    
}
