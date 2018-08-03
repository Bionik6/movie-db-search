//
//  APIKeyFetcher.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation

final class APIKeyFetcher {
    
    func fetchKey() -> String? {
        guard let path = Bundle.main.path(forResource: "APIKey", ofType: "plist") else { return nil }
        let dictionary = NSDictionary(contentsOfFile: path)
        return dictionary?.value(forKey: "api_key") as? String
    }
    
}
