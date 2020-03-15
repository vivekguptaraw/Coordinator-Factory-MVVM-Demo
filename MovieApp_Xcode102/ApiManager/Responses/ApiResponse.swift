//
//  ApiResponse.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 29/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation
import Alamofire

struct ApiResponse<Value: Codable> {
    
    var request: URLRequest?
    var response: HTTPURLResponse?
    var data: Data?
    var result: Result<Value, ApiNetworkError>
    
}
