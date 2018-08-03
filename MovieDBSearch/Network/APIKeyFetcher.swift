//
//  APIKeyFetcher.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation

final class APIKeyFetcher {
    
    var request: Request
    
    init(request: Request) {
        self.request = request
    }
    
    func fetchKey() {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        guard let URL = URL(string: "https://niawalma.app/api/v1/moviedb/api_key") else {return}
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        session.dataTask(with: request) { (data, response, error) in
            if (error == nil) {
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
            }.resume()
    }
    
}
