//
//  FetchUpcomingMoviesRequest.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 29/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

struct FetchUpcomingMoviesRequest: MoviesApiRequestProtocol {
    
    var path: String = "/movie/now_playing"
    
    var parameters: [String : Any] {
        return [
            "page": page
        ]
    }
    
    private let page: Int
    
    init(page: Int) {
        self.page = page
    }
}
