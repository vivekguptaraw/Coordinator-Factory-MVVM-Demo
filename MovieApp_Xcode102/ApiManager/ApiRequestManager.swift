//
//  ApiRequestManager.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 29/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation
import Alamofire

public enum ApiNetworkError: Error {
    case unknown
    case connectionError(Error)
    case invalidData
}

typealias Completion<T: Codable> = (_ responseObject: Codable) -> Void
typealias CommonNetworkRequest = DataRequest

class RequestManager {
    static var shared = RequestManager()
    private let sessionManager = Session.default
    
    private init() {
        
    }
    
    
    @discardableResult func perform<T: Codable>(_ request: MoviesApiRequestProtocol, handleCompletion: @escaping (ApiResponse<T>) -> Void) -> CommonNetworkRequest? {
        
        let dataRequest = sessionManager.request(request)
        dataRequest.responseData { (apiResponseData: AFDataResponse<Data>) in
            let result: Result<T, ApiNetworkError>
            let statusCode = apiResponseData.response?.statusCode ?? 0
            if statusCode == 0 {
                result = .failure(.unknown)
            } else {
                print("==> Result of URL  \(apiResponseData.request?.url?.absoluteString)")
                switch apiResponseData.result {
                case .success(let successsData):
                    let decoder = JSONDecoder()
                    do {
                        let receivedResponse = try decoder.decode(T.self, from: successsData)
                            result = .success(receivedResponse)
                    } catch {
                        print("==> Error in \(apiResponseData.request?.url?.absoluteString) \n \(error)")
                        result = .failure(.invalidData)
                    }
                    
                
//                    if let codable = T(jsonData: successsData) {
//                        result = .success(codable)
//                    } else {
//                        result = .failure(.invalidData)
//                    }
                    
                case .failure(let failedData):
                    result = .failure(.connectionError(failedData))
                }
            }
            let apiResponse = ApiResponse<T>(request: dataRequest.request, response: apiResponseData.response, data: apiResponseData.data, result: result)
            handleCompletion(apiResponse)
        }
        
        return dataRequest
    }
}
