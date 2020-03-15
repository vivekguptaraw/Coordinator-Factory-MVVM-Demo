//
//  DateTransformers.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 29/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

public class DateTransformer: CodableTransformer {
    
    public typealias Input = String
    public typealias Output = Date
    
    public init() {}
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    public func transform(_ decoded: String) throws -> Date {
        return dateFormatter.date(from: decoded) ?? Date(timeIntervalSince1970: 0)
    }
    
    public func transform(_ encoded: Date) throws -> String {
        return dateFormatter.string(from: encoded)
    }
    
}

