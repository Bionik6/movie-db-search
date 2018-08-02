//
//  Theme.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit


public enum Theme {
    
    public static var navBarAppearance: UINavigationBar { return UINavigationBar.appearance() }
    
    public enum Colors {
        case white
        case halfWhite
        case gradientPrimary
        case gradientSecondary
        case backgroundColor
        
        public var value: UIColor {
            switch self {
            case .white: return UIColor(hex: "FFFFFF")
            case .halfWhite: return UIColor(hex: "FFFFFF", alpha: 0.5)
            case .gradientPrimary: return UIColor(hex: "F46E72")
            case .gradientSecondary: return UIColor(hex: "AF4B78")
            case .backgroundColor: return UIColor(hex: "1D1D25")
            }
        }
    }
    
    public enum Fonts {
        case avenirNextRegular(size: CGFloat)
        case avenirNextBlack(size: CGFloat)
        case avenirNextBold(size: CGFloat)
        case avenirNextMedium(size: CGFloat)
        
        public var value: UIFont {
            switch self {
            case .avenirNextRegular(let size):
                return UIFont(name: "AvenirNext-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
            case .avenirNextBlack(let size):
                return UIFont(name: "AvenirNext-Black", size: size) ?? UIFont.systemFont(ofSize: size, weight: .black)
            case .avenirNextBold(let size):
                return UIFont(name: "AvenirNext-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
            case .avenirNextMedium(let size):
                return UIFont(name: "AvenirNext-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
            }
        }
    }
    
    public static var gradientColors: [UIColor] {
        return [Colors.gradientPrimary.value,
                Colors.gradientSecondary.value]
    }
    
    static func applyDefaultAppearance() {
        navBarAppearance.tintColor = Colors.white.value
        navBarAppearance.titleTextAttributes = [NSAttributedStringKey.foregroundColor: Theme.Colors.white.value,
                                                NSAttributedStringKey.font: Theme.Fonts.avenirNextMedium(size: 20).value]
        navBarAppearance.barTintColor = Colors.backgroundColor.value
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
}
