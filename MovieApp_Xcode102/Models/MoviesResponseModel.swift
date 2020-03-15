//
//  MoviesResponseModel.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 29/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//


import Foundation

struct MoviesResponseModel: Codable {
    
    private(set) var results: [MovieModel]?
    private(set) var page: Int?
    private(set) var totalResults: Int?
    private(set) var totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
    
}

