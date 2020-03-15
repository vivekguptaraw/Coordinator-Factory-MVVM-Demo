//
//  MovieModel.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 29/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

struct MovieModel: Codable {
    
    // Required
    var id: Int
    var title: String?
    
    // Optionals
    private var posterPath: String?
    var overview: String?
    var releaseDate: Date?
    var originalTitle: String?
    var originalLanguage: String?
    var genreIDs: [Int]?
    private var backdropPath: String?
    var popularity: Double?
    var voteCount: Int?
    var voteAverage: Double?
    var isAdult: Bool?
    var isVideo: Bool?
    
    init(id: Int, title: String, overview: String? = nil, posterPath: String? = nil, releaseDate: Date? = nil) {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = posterPath
        self.releaseDate = releaseDate
    }
    
    // MARK: Codable Protocol
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case genreIDs = "genre_ids"
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case isVideo = "video"
        case isAdult = "adult"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(.id)
        title = try container.decode(.title)
        posterPath = try? container.decode(.posterPath)
        overview = try? container.decode(.overview)
        releaseDate = try? container.decode(.releaseDate, transformer: DateTransformer())
        originalTitle = try? container.decode(.originalTitle)
        originalLanguage = try? container.decode(.originalLanguage)
        genreIDs = try? container.decode(.genreIDs)
        backdropPath = try? container.decode(.backdropPath)
        popularity = try? container.decode(.popularity)
        voteCount = try? container.decode(.voteCount)
        voteAverage = try? container.decode(.voteAverage)
        isVideo = try? container.decode(.isVideo)
        isAdult = try? container.decode(.isAdult)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try? container.encode(posterPath, forKey: .posterPath)
        try? container.encode(overview, forKey: .overview)
        if let date = releaseDate {
            try container.encode(date, forKey: .releaseDate, transformer: DateTransformer())
        }
        try? container.encode(originalTitle, forKey: .originalTitle)
        try? container.encode(originalLanguage, forKey: .originalLanguage)
        try? container.encode(genreIDs, forKey: .genreIDs)
        try? container.encode(backdropPath, forKey: .backdropPath)
        try? container.encode(popularity, forKey: .popularity)
        try? container.encode(voteCount, forKey: .voteCount)
        try? container.encode(voteAverage, forKey: .voteAverage)
        try? container.encode(isVideo, forKey: .isVideo)
        try? container.encode(isAdult, forKey: .isAdult)
    }
    
}

extension MovieModel: ViewBindableProtocol {
    
    func getTitle() -> String {
        return title ?? ""
    }
    
    func getSubtitle() -> String {
        guard let date = releaseDate else {
            return ""
        }
        return DateFormatter.string(from: date, format: "MMMM YYYY")
    }
    
    func getImageURL(size: ImageSize) -> URL? {
        guard let path = posterPath else {
            return nil
        }
        return URL.getMovieImageSoucreURL(fromPath: path, size: size)
    }
    
    func getSubText() -> String? {
        return overview
    }
    
}

extension MovieModel: Equatable {
    static func ==(lhs: MovieModel, rhs: MovieModel) -> Bool {
        return lhs.id == rhs.id // For now id comparision is enough
    }
}
