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
        registerSearchService(container: container)
        registerSuggestionPersistence(container: container)
    }
}


extension SearchAssembly {
    
    private func registerPageParser(container: Container) {
        container.register(PageParser.self, factory: { resolver in
            return PageJSONParser()
        })
    }
    
    private func registerDisPatcher(container: Container) {
        container.register(Dispatcher.self, factory: { resolver in
            let client = APIClient.init(session: URLSession.init(configuration: .default))
            return client
        })
    }
    
    private func registerSuggestionPersistence(container: Container) {
        container.register(SuggestionPersistence.self, factory: { resolver in
            let persistence = DefaultSuggestionPersistence()
            return persistence
        })
    }
    
    private func registerSearchService(container: Container) {
        container.register(SearchService.self, factory: { resolver in
            let client = mainAssembler?.resolver.resolve(Dispatcher.self)!
            let parser = mainAssembler?.resolver.resolve(PageParser.self)!
            let persistence = mainAssembler?.resolver.resolve(SuggestionPersistence.self)!
            let searchService = SearchService(client: client!, parser: parser!, persistence: persistence!)
            return searchService
        })
    }
    
}
