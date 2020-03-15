//
//  PaginationSection.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 29/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

enum PaginationSection: Int {
    case content = 0
    case loading = 1
    
    static var count: Int {
        var max: Int = 0
        while let _ = self.init(rawValue: max) {
            max += 1
        }
        return max
    }
    
    static let offset = 5
}
