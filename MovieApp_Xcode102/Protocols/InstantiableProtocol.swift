//
//  InstantiableProtocol.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 29/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit

protocol InstantiableProtocol {
    static func instantiate() -> Self
}

extension InstantiableProtocol where Self: NibLoadableProtocol {
    static func instantiate() -> Self {
        return loadFromNib()
    }
}
