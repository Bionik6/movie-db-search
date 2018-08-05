//
//  HudDisplayable.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit
import MBProgressHUD


/// Show and Hide a HUD on network call. Handy for slow internet connection
protocol HudDisplayable: AnyObject { }

extension HudDisplayable where Self: UIViewController {
    
    /// Show the HUD in the center of a view
    ///
    /// - Parameters:
    ///   - title: The title of the HUD
    ///   - message: The message of the HUD
    ///   - mode: The displaying mode of the HUD
    func showHUD(title: String, message: String, mode: MBProgressHUDMode = .indeterminate) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = title
        hud.detailsLabel.text = message
        hud.isUserInteractionEnabled = false
        hud.animationType = .fade
        hud.mode = mode
        self.view.isUserInteractionEnabled = false
    }
    
    /// Hide the HUD
    func hideHUD() {
        executeInMainThread {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.isUserInteractionEnabled = true
        }
    }
}
