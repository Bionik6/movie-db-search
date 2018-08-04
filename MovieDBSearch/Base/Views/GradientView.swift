//
//  GradientView.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit

@IBDesignable
public class GradientView: UIView {
    
    private var colors: [UIColor] = []
    private var startPoint: CGPoint = CGPoint(x: 0, y: 0.7)
    private var endPoint: CGPoint = CGPoint(x: 0.6, y: 0.3)
    
    var gradientLayer: CAGradientLayer? { return layer as? CAGradientLayer }
    
    override public class var layerClass: AnyClass { return CAGradientLayer.self }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        self.colors = Theme.gradientColors
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.startPoint = startPoint
        gradientLayer?.endPoint = endPoint
        gradientLayer?.colors = colors.compactMap { $0.cgColor }
    }
    
}
