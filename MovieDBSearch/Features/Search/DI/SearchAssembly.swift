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
        registerPageParser(container: container)
        registerQueryPersistence(container: container)
    }
}


extension SearchAssembly {
    
    fileprivate func registerParser(container: Container) {
        container.register(MovieParser.self, factory: { resolver in
            return MovieJSONParser()
        })
    }
    
    fileprivate func registerPageParser(container: Container) {
        container.register(PageParser.self, factory: { resolver in
            return PageJSONParser()
        })
    }
    
    fileprivate func registerDisPatcher(container: Container) {
        container.register(Dispatcher.self, factory: { resolver in
            let client = APIClient.init(session: URLSession.init(configuration: .default))
            return client
        })
    }
    
    fileprivate func registerQueryPersistence(container: Container) {
        container.register(QueryPersistence.self, factory: { resolver in
            let persistence = JSONQueryPersistence()
            return persistence
        })
    }
    
}
