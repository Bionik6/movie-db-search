//
//  CustomTextField.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    @IBInspectable var leftPadding: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = 4.0
        layer.masksToBounds = true
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: frame.height))
        leftViewMode = .always
        let attributes = [NSAttributedStringKey.foregroundColor: Theme.Colors.halfWhite.value]
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
    }
}
