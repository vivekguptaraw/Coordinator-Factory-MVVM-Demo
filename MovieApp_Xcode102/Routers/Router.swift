//
//  Router.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 07/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

typealias NavigationBackClosure = (() -> ())

protocol Router: Presentable {
    
    func push(_ module: Presentable?)
    
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)
    
    func popModule()
    func popModule(animated: Bool)
    
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    
    func popToRootModule(animated: Bool)
}
