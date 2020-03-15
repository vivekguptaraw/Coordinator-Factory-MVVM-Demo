//
//  Coordinator.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 07/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    func start()
    func start(with option: DeeplinkPath?)
}
