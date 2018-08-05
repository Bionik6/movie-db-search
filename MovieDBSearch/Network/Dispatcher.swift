//
//  Dispatcher.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Foundation


/// Protocol for making network requests
protocol Dispatcher: AnyObject {
    
    var baseURL: NSString { get set }
    var session: SessionProtocol { get set }
    
    init(session: SessionProtocol)
    
    func execute(request: Request, completion: @escaping (BackendResponse<Data?>)->())
    
}
