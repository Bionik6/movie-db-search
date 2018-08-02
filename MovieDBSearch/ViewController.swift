//
//  ViewController.swift
//  MovieDBSearch
//
//  Created by Ibrahima Ciss on 8/1/18.
//  Copyright © 2018 Ibrahima Ciss. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var regular: UILabel!
    
    @IBOutlet weak var medium: UILabel!
    
    @IBOutlet weak var bold: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

