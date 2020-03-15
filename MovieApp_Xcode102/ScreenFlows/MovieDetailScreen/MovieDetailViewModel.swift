//
//  MovieDetailViewModel.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 08/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

class MovieDetailViewModel: MovieDetailProtocol {
    
    var state: MovieDetailState = MovieDetailState()
    
    var onFetched: ((MovieDetailState.ChangeStateForMovieDetail) -> Void)?
    var movieModel: MovieModel?
    var similarMovieDataSource: SimilarMovieDataSource?
    var castMovieDataSource: CastsDataSource?
    var crewMovieDataSource: CrewDataSource?
    
    init(movieModel: MovieModel) {
        self.movieModel = movieModel
    }
    
    func loadSynopsis() {
        guard let id = movieModel?.id else { return }
        self.fetchSynopsis(movieId: id) {[weak self] (synopsis) in
            guard let slf = self else {return}
            slf.state.setSynopsis(model: synopsis)
            slf.onFetched?(.synopsysFetched)
        }
    }
    
    func loadReviews() {
        guard let id = movieModel?.id else { return }
        self.fetchReviews(movieId: id) {[weak self]  (review) in
            guard let slf = self else {return}
            slf.state.setReviews(model: review)
            slf.onFetched?(.reviewsFetched)
        }
    }
    
    func loadCredits() {
        guard let id = movieModel?.id else { return }
        self.fetchCredits(movieId: id) {[weak self]  (credit) in
            guard let slf = self else {return}
            slf.state.setCredits(model: credit)
            slf.onFetched?(.creditsFetched)
        }
    }
    
    func loadSimilarMovies() {
        guard let id = movieModel?.id else { return }
        self.fetchSimilarMoview(movieId: id) {[weak self]  (similar) in
            guard let slf = self else {return}
            slf.state.setSimilarMovies(similar: similar)
            slf.onFetched?(.similarMoviesFetched)
        }
    }
}

extension MovieDetailViewModel {
    func fetchSynopsis(movieId: Int, completion: @escaping (MovieSynopsisModel) -> Void) {
        let request = FetchMovieSynopsis(movieId: "\(movieId)")
        RequestManager.shared.perform(request) { [weak self] (reponse: ApiResponse<MovieSynopsisModel>) in
            guard let slf = self else {return}
            switch reponse.result {
            case .success(let value):
                completion(value)
            case .failure(let value):
                slf.onFetched?(.error(.connectionError(value)))
            }
        }
    }
    
    func fetchReviews(movieId: Int, completion: @escaping (MovieReviewsResponse) -> Void) {
        let request = FetchMovieReviews(movieId: "\(movieId)")
        RequestManager.shared.perform(request) { [weak self] (reponse: ApiResponse<MovieReviewsResponse>) in
            guard let slf = self else {return}
            switch reponse.result {
            case .success(let value):
                completion(value)
            case .failure(let value):
                slf.onFetched?(.error(.connectionError(value)))
            }
        }
    }
    
    func fetchCredits(movieId: Int, completion: @escaping (MovieCreditsModel) -> Void) {
        let request = FetchMovieCredits(movieId: "\(movieId)")
        RequestManager.shared.perform(request) { [weak self] (reponse: ApiResponse<MovieCreditsModel>) in
            guard let slf = self else {return}
            switch reponse.result {
            case .success(let value):
                completion(value)
            case .failure(let value):
                slf.onFetched?(.error(.connectionError(value)))
            }
        }
    }
    
    func fetchSimilarMoview(movieId: Int, completion: @escaping (MoviesResponseModel) -> Void) {
        let request = FetchSimilarMovies(movieId: "\(movieId)")
        RequestManager.shared.perform(request) { [weak self] (reponse: ApiResponse<MoviesResponseModel>) in
            guard let slf = self else {return}
            switch reponse.result {
            case .success(let value):
                completion(value)
            case .failure(let value):
                slf.onFetched?(.error(.connectionError(value)))
            }
        }
    }
    
}

class GenericDataSource<T> : NSObject {
    //var data: DynamicValue<[T]> = DynamicValue([])
}

extension MovieDetailViewModel {
    
}
