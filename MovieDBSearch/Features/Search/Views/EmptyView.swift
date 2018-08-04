//
//  EmptyView.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/4/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit

class EmptyView: BaseView {
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Theme.Fonts.avenirNextMedium(size: 20).value
        label.textColor = Theme.Colors.halfWhite.value
        label.numberOfLines = 0
        return label
    }()
    
    override func setupView() {
        imageView.center(in: self, offset: CGPoint(x: 0, y: -100))
        descriptionLabel.top(with: imageView.bottomAnchor, value: 30)
            .leading(to: self, value: 24)
            .trailing(to: self, value: -24)
    }
    
    override func initializeView() {
        add(subviews: [imageView, descriptionLabel])
    }
    
}
