//
//  APIClient.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation


/// Main Dispatcher of the App
final class APIClient: Dispatcher {
    
    var session: SessionProtocol
    var baseURL: NSString = "http://api.themoviedb.org/3/"
    
    required init(session: SessionProtocol) {
        self.session = session
    }
    
    
    /// Make an API call based on a given request
    ///
    /// - Parameters:
    ///   - request: The Request to call
    ///   - completion: The callback containing the response of the request
    func execute(request: Request, completion: @escaping (BackendResponse<Data?>)->()) {
        session.dataTask(with: self.prepareURLRequest(for: request)) { (data, response, error) in
            if (error == nil) {
                completion(.success(data))
            }
            else {
                let domainError = error! as NSError
                if domainError.code == -1009 {
                    completion(.failure(ResponseError.noInternetConnection))
                    return
                }
                completion(.failure(ResponseError.unknown(message: domainError.localizedDescription)))
            }
        }.resume()
    }
    
}


extension APIClient {
    
    
    /// Prepare the Request with it's parameters and/or header
    ///
    /// - Parameter request: The Request to prepare
    /// - Returns: A request with all the parameters ready to be executed
    fileprivate func prepareURLRequest(for request: Request) -> URLRequest {
        let fullURLString = baseURL.appendingPathComponent(request.path)
        guard let url = URL(string: fullURLString) else { fatalError("The URL is not valid") }
        var urlRequest = URLRequest(url: url)

        // Prepare request params for a body json payload or query params
        if let params = request.params {
            switch params {
            case .body(let bodyParams):
                urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParams, options: .init(rawValue: 0))
            case .url(let urlParams):
                var components = URLComponents(string: fullURLString)!
                components.queryItems = urlParams.map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
                urlRequest.url = components.url
            }
        }
        
        // Add headers if any
        if let headers = request.headers { headers.forEach { urlRequest.addValue($0.value , forHTTPHeaderField: $0.key) } }
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpMethod = request.method.rawValue
        return urlRequest
    }

}
