//
//  MovieDetailViewModel.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 08/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

struct MovieDetailState {
    fileprivate(set) var synopsis: MovieSynopsisModel?
    fileprivate(set) var reviews: MovieReviewsResponse?
    fileprivate(set) var credits: MovieCreditsModel?
    fileprivate(set) var similarMovies: MoviesResponseModel?
}

protocol MovieDetailProtocol{
    var state: MovieDetailState { get }
    var onFetched: ((MovieDetailState.ChangeStateForMovieDetail) -> Void)? { get set}
    func loadSynopsis()
    func loadReviews()
    func loadCredits()
    func loadSimilarMovies()
}

extension MovieDetailState {
    enum ChangeStateForMovieDetail {
        case none
        case synopsysFetched
        case reviewsFetched
        case creditsFetched
        case similarMoviesFetched
        case error(MovieListError)
    }
    
    mutating func setSynopsis(model: MovieSynopsisModel) {
        self.synopsis = model
    }
    
    mutating func setReviews(model: MovieReviewsResponse) {
        self.reviews = model
    }
    
    mutating func setCredits(model: MovieCreditsModel) {
        self.credits = model
    }
    
    mutating func setSimilarMovies(similar: MoviesResponseModel) {
        self.similarMovies = similar
    }
}
