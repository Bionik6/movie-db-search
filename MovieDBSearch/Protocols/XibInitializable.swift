//
//  XibInitializable.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/2/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit


/// Handle Xib Initialization
protocol XibInitializable: class {
    var xibName: String { get }
    var xibBundle: Bundle? { get }
    func setupView()
}

extension XibInitializable where Self: UIView {
    
    var xibBundle: Bundle? { return Bundle(for: Self.self) }
    var xibName: String { return String(describing: Self.self) }
    
    
    /// Automatically getting and unarchiving the Xib based on his name
    func setupXib() {
        guard let view = xibBundle?.loadNibNamed(xibName, owner: self, options: nil)?.first as? UIView
            else { preconditionFailure("Could not load \(xibName) from Nib") }
        addSubview(view)
        view.frame = bounds
    }
}

