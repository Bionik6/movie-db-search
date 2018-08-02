//
//  BaseView.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
        setupView()
    }
    
    func setupView() { fatalError("To be implemented by subclasses") }
    
    func initializeView() { fatalError("To be implemented by subclasses") }
}
