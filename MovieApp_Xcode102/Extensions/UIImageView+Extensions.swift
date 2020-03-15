//
//  UIImageView+Extensions.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 01/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    func assignActivityIndicator() {
        if self != nil {
            var kf = self.kf
            kf.indicatorType = .activity
        }
    }
}
