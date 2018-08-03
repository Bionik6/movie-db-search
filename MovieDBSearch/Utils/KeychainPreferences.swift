//
//  KeychainPreferences.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation
import KeychainAccess


final class KeychainPreferences {
    
    let keychain: Keychain
    
    static let shared: KeychainPreferences = KeychainPreferences()
    
    private init(service: String = "kreativelab.co.MovieDBSearch") {
        let keychain = Keychain(service: service)
        self.keychain = keychain
    }
    
    var API_KEY: String? {
        get { return keychain[string: #function] }
        set { keychain[string: #function] = newValue }
    }
    
}
