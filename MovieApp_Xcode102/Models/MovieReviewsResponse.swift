//
//  MovieReviewsResponse.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 08/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation


// MARK: - MovieReviewsModel
struct MovieReviewsResponse: Codable {
    let id, page: Int?
    let results: [MovieReviewModel]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
