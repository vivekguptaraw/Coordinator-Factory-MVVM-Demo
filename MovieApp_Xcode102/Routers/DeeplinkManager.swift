//
//  DeeplinkManager.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 07/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

let appSchema = "movieapp://"
let appHost = "deeplink"

struct DeeplinkURLStrings {
    static let Splash = "Splash"
    static let NowPlaying = "NowPlaying"
    static let MovieDetail = "MovieDetail"
}

enum DeeplinkPath {
    case Splash
    case NowPlaying
    case MovieDetail(movieId: Int?)
    
    static func openScreen(param: [AnyHashable: Any]?) -> DeeplinkPath? {
        guard let strUrl = param?[appHost] as? String, let url = URL(string: strUrl) else { return nil }
        return parseDeepLink(url)
    }
    
    static func parseDeepLink(_ url: URL) -> DeeplinkPath? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true), let host = components.host else {
            return nil
        }
        var pathComponents = components.path.components(separatedBy: "/")
        pathComponents.removeFirst()
        // Here we can handle multiple schema that we support.
        if url.scheme == appSchema {
            if host == appHost {
                guard let path = pathComponents.first else {return nil}
                
                switch path {
                case DeeplinkURLStrings.Splash:
                    return .Splash
                case DeeplinkURLStrings.NowPlaying:
                    return .NowPlaying
                case DeeplinkURLStrings.MovieDetail:
                    var id: Int?
                    if let queryItem = components.queryItems {
                        for item in queryItem {
                            if  item.name == "movieid", let val = item.value, let intId = Int(val) {
                                id = intId
                            }
                        }
                    }
                    return .MovieDetail(movieId: id)
                default:
                    return nil
                }
            }
            return nil
        }
        return nil
    }
}

