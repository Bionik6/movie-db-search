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
        container.register(MovieDataProvider.self, factory: { _ in
            let session = URLSession(configuration: .default)
            let client = APIClient(session: session)
            return MovieDataProvider(client: client)
        }).inObjectScope(.container)
    }
}



final class MovieDataProvider: NSObject, UICollectionViewDataSource {
    
    private let client: Dispatcher
    
    init(client: Dispatcher) {
        self.client = client
    }
    
    var didFinishFetchingData: ()->() = {  }
    
    func fetchMovies(for searchTerms: String, completion: @escaping (BackendResponse<Data?>)->()) {
        let request = SearchRequest(searchTerms: searchTerms)
        client.execute(request: request) { response in
            switch response {
            case .success(let data):
                let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print(json)
            case .failure(let error): print(error)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell.init()
    }
}
