//
//  HudDisplayable.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol HudDisplayable: AnyObject { }

extension HudDisplayable where Self: UIViewController {
    
    func showHUD(title: String, message: String, mode: MBProgressHUDMode = .indeterminate) {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = title
        hud.detailsLabel.text = message
        hud.isUserInteractionEnabled = false
        hud.animationType = .fade
        hud.mode = mode
        self.view.isUserInteractionEnabled = false
    }
    
    func hideHUD() {
        executeInMainThread {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.isUserInteractionEnabled = true
        }
    }
}
