//
//  URL+Extensions.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 01/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

enum ImageSize {
    case w92
    case ​w185
    case ​w500
    case w780
    
    func string() -> String {
        switch self {
        case .w92:
            return "/w92"
        case .​w185:
            return "/w185"
        case .​w500:
            return "/w500"
        case .w780:
            return "/w780"
        }
    }
}

extension URL {
    
    static private let baseURL = URL(string: "http://image.tmdb.org/t/p")!
    
    static func getMovieImageSoucreURL(fromPath path: String, size: ImageSize) -> URL {
        var url = baseURL.appendingPathComponent(size.string())
        url = url.appendingPathComponent(path)
        return url
    }
    
}
