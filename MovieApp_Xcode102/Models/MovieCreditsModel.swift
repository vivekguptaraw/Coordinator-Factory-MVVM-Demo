//
//  MovieCreditsModel.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 08/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

// MARK: - MovieCreditsModel
struct MovieCreditsModel: Codable {
    let id: Int?
    let cast: [Cast]?
    let crew: [Crew]?
}

// MARK: - Cast
struct Cast: Codable {
    let castID: Int?
    let character, creditID: String?
    let gender, id: Int?
    let name: String?
    let order: Int?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case gender, id, name, order
        case profilePath = "profile_path"
    }
}

extension Cast: ViewBindableProtocol {
    func getImageURL(size: ImageSize) -> URL? {
        if let path = self.profilePath {
            let url = URL.getMovieImageSoucreURL(fromPath: path, size: .​w185)
            return url
        }
        return nil
    }
}

// MARK: - Crew
struct Crew: Codable {
    let creditID, department: String?
    let gender, id: Int?
    let job, name: String?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case department, gender, id, job, name
        case profilePath = "profile_path"
    }
}

extension Crew: ViewBindableProtocol {
    func getImageURL(size: ImageSize) -> URL? {
        if let path = self.profilePath {
            let url = URL.getMovieImageSoucreURL(fromPath: path, size: .​w185)
            return url
        }
        return nil
    }
}
