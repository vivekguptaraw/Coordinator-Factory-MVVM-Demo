//
//  FetchMovieSynopsis.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 06/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

struct FetchMovieSynopsis: MoviesApiRequestProtocol {
    var path: String = "/movie/"
    
    init(movieId: String) {
        path += movieId
    }
}
