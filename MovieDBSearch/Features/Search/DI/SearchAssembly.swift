//
//  SearchAssembly.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Swinject


final class SearchAssembly: Assembly {
    
    func assemble(container: Container) {
        registerParser(container: container)
        registerDisPatcher(container: container)
    }
}


extension SearchAssembly {
    
    fileprivate func registerParser(container: Container) {
        container.register(Parser.self, factory: { resolver in
            return JSONParser()
        })
    }
    
    fileprivate func registerDisPatcher(container: Container) {
        container.register(Dispatcher.self, factory: { resolver in
            let client = APIClient.init(session: URLSession.init(configuration: .default))
            return client
        })
    }
}
