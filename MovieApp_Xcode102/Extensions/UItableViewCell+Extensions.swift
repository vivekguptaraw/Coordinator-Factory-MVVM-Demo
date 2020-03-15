//
//  UItableViewCell+Extensions.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 01/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
    
}
