//
//  AlertShowable.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit

protocol AlertShowable { }

extension AlertShowable where Self: UIViewController {
    
    
    /// Show an Alert of type UIAlertController
    ///
    /// - Parameters:
    ///   - title: The title of the Alert
    ///   - message: The message of the Alert
    ///   - completion: The block that should be call when we dismiss the alert
    func showAlert(title: String, message: String, completion: (()->())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in completion?() }
        alertController.addAction(action)
        executeInMainThread { self.present(alertController, animated: true, completion: nil) }
    }
    
}
