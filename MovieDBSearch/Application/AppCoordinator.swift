//
//  AppCoordinator.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit

final class AppCoordinator {
    
    private let window: UIWindow
    private var navigationController: UINavigationController!
    
    init(window: UIWindow) {
        self.window = window
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        setupRootViewController()
        window.rootViewController = navigationController
        Theme.applyDefaultAppearance()
    }
    
    private func setupRootViewController() {
        let searchVC = SearchViewController()
        navigationController = UINavigationController(rootViewController: searchVC)
        navigationController.navigationBar.isTranslucent = false
    }
}
