//
//  Helpers.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit

var isIphoneXOrBigger: Bool {
    return UIScreen.main.bounds.height >= 812
}


/// Helper Method for executing task in the main Thread
///
/// - Parameter completion: The block to be executed in the Main Thread
func executeInMainThread(completion: @escaping ()->()) {
    OperationQueue.main.addOperation { completion() }
}
