//
//  BaseApiRequestProtocol.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 29/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation
import Alamofire

public protocol BaseApiRequestProtocol: URLRequestConvertible {
    
    // The target's base `URL`.
    var baseURL: URL { get }
    
    // The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    // The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    // The HTTP parameters used in the request.
    var parameters: Parameters { get }
    
    // The HTTP parameters encoding format used in the request
    var encoding: ParameterEncoding { get }
    
    // The headers to be used in the request.
    var headers: [String: String]? { get }
    
}

