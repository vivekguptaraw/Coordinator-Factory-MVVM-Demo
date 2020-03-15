//
//  ViewBindableProtocol.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 29/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

protocol ViewBindableProtocol {
    
    func getTitle() -> String
    func getSubtitle() -> String
    func getImageURL(size: ImageSize) -> URL?
    func getSubText() -> String?
    
}

extension ViewBindableProtocol {
    
    func getTitle() -> String {
        return ""
    }
    
    func getSubtitle() -> String {
        return ""
    }
    
    func getImageURL() -> URL? {
        return nil
    }
    
    func getSubText() -> String? {
        return nil
    }
    
}

