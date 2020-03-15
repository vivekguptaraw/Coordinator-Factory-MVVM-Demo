//
//  BaseNavigationController.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 29/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        navigationBar.tintColor = .red
    }
    
}

