//
//  UIColor+Hex.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit

extension UIColor {
    
    var CIColorepresentable: CIColor {
        return CIColor(color: self)
    }
    
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        return (CIColorepresentable.red,
                CIColorepresentable.green,
                CIColorepresentable.blue,
                CIColorepresentable.alpha)
    }
    
    convenience init(theme: Theme.Colors) {
        self.init(red: theme.value.components.red,
                  green: theme.value.components.green,
                  blue: theme.value.components.blue,
                  alpha: theme.value.components.alpha)
    }
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: alpha
        )
    }
    
}
