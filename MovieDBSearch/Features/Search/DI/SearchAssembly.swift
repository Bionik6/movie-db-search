//
//  SearchAssembly.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/3/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import Swinject



/// Assemble our assemblies in the container
final class SearchAssembly: Assembly {
    
    
    /// Register all the dependencies to the container
    ///
    /// - Parameter container: The default container where all our objects are registered
    func assemble(container: Container) {
        registerDisPatcher(container: container)
        registerPageParser(container: container)
        registerSuggestionPersistence(container: container)
    }
}


extension SearchAssembly {
    
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
    
    fileprivate func registerSuggestionPersistence(container: Container) {
        container.register(SuggestionPersistence.self, factory: { resolver in
            let persistence = DefaultSuggestionPersistence()
            return persistence
        })
    }
    
}
