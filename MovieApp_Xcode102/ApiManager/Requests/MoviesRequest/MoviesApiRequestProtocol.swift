//
//  MoviesApiRequestProtocol.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 29/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation
import Alamofire

private let APIKey = "d2fb61f0b4cb219511074c8a6379f775"

protocol MoviesApiRequestProtocol: BaseApiRequestProtocol { }

extension MoviesApiRequestProtocol {
    
    var baseURL: URL                { return URL(string: "https://api.themoviedb.org/3")! }
    var method: HTTPMethod          { return .get }
    var parameters: [String: Any]   { return [:] }
    var headers: [String: String]?  { return nil }
    var encoding: ParameterEncoding { return URLEncoding.default }

    public func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("==> API URL resolution issue...")
        }
        
        // Create a api query Item
        let apiKeyItem = URLQueryItem(name: "api_key", value: APIKey)
        
        // Add APIKey to query Items
        var queryItems = components.queryItems ?? []
        queryItems.append(apiKeyItem)
        components.queryItems = queryItems
        
        // Check the components for url
        guard let queriedURL = components.url else {
            fatalError("==> URL cannot be constructed from URL components!")
        }
        
        do {
            var request = URLRequest(url: queriedURL)
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = headers
            return try encoding.encode(request, with: parameters)
        } catch {
            throw error
        }
    }
    
}

