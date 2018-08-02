//
//  AppDelegate.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/1/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow!
    lazy var coordinator = AppCoordinator(window: window)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        Theme.applyDefaultAppearance()
        coordinator.start()
        return true
    }

}

