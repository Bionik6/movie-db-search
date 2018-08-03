//
//  MovieDataProvider.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit
import Swinject


final class MovieDataProviderAssembly: Assembly {
    
    func assemble(container: Container) {
//        container.register(MovieDataProvider.self, factory: { _ in
//            let session = URLSession(configuration: .default)
//            let client = APIClient(session: session)
//            return MovieDataProvider(client: client)
//        }).inObjectScope(.container)
    }
}



final class MovieDataProvider: NSObject, UICollectionViewDataSource {
    
    private var movies: [Movie] = []
    var didFinishFetchingData: ()->() = {  }
    
    var searchTerms: String = "" {
        didSet {
            factory.fetchMovies(for: searchTerms) { response in
                print(response)
                self.didFinishFetchingData()
            }
        }
    }
    
    private lazy var factory: SearchFactory = {
        let client = mainAssembler?.resolver.resolve(Dispatcher.self)!
        let parser = mainAssembler?.resolver.resolve(Parser.self)!
        return SearchFactory(client: client!, parser: parser!)
    }()


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell.init()
    }
}
