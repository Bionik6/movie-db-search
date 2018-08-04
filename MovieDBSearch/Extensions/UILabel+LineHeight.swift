//
//  UILabel+LineHeight.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit

extension UILabel {
    
    func set(lineHeight: CGFloat, alignment: NSTextAlignment = .left) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight
        paragraphStyle.alignment = alignment
        let attributedText = NSAttributedString(string: self.text ?? "", attributes: [NSAttributedStringKey.paragraphStyle: paragraphStyle])
        self.attributedText = attributedText
    }
    
}
