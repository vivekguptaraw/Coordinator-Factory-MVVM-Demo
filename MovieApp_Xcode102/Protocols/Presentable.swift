//
//  Presentable.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 07/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit

protocol Presentable {
    func toPresent() -> UIViewController?
}

protocol BaseView: NSObjectProtocol, Presentable { }

extension UIViewController: Presentable {
    
    func toPresent() -> UIViewController? {
        return self
    }
}

