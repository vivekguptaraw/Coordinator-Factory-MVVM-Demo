//
//  DateFormatter+Additions.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 29/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static private let customDateFormatter = DateFormatter()
    
    static func string(from date: Date, format: String) -> String {
        customDateFormatter.dateFormat = format
        return customDateFormatter.string(from: date)
    }
    
    static func date(from string: String, format: String) -> Date? {
        customDateFormatter.dateFormat = format
        return customDateFormatter.date(from: string)
    }
    
}
