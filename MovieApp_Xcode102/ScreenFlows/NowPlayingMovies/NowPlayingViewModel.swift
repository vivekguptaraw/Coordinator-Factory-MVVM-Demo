//
//  NowPlayingViewModel.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 01/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

class NowPlayingViewModel: MovieViewModel {
    
    fileprivate(set) var state = MovieListState()
    var onChange: ((MovieListState.ChangeStateForList) -> Void)?
    
    func reloadMovies() {
        state.update(page: .default)
        fetch(at: self.state.page.currentPage) {[weak self] (movieArray) in
            guard let slf = self else {return}
            slf.onChange?(slf.state.reload(movies: movieArray))
        }
    }
    
    func loadMoreMovies() {
        guard state.page.hasNextPage else { return }
        fetch(at: state.page.getNextPage()) {[weak self] (movieArray) in
            guard let slf = self else {return}
            slf.onChange?(slf.state.insert(movies: movieArray))
        }
    }
    
    func searchMovies(text: String) {
        onChange?(state.setSearchFetching(searching: true))
        let txt = text.trimmingCharacters(in: .whitespacesAndNewlines)
        let filteredData = txt.isEmpty ? state.moviesArray : state.moviesArray.filter { (model) -> Bool in
            guard let title = model.title else { return false}
            let patterns = createRegEx(pattern: txt)
            return self.searchAnyTextsInList(movieTitle: title, searchRegExArray: patterns)
        }
        if filteredData.count < self.state.moviesArray.count {
            self.onChange?(self.state.setSearchMoviesArray(movies: filteredData))
        } else {
            onChange?(state.setSearchFetching(searching: false))
            self.onChange?(self.state.reload(movies: state.moviesArray))
            
        }
        
    }
    
    func searchAnyTextsInList(movieTitle: String, searchRegExArray: String) -> Bool {
        var found = false
        if let range = movieTitle.range(of: searchRegExArray, options: [.regularExpression,.caseInsensitive]) {
            found = true
        }
        return found
        
    }
    
    func createRegEx(pattern: String) -> String{
        let words = pattern.components(separatedBy: " ")
        var regexArray: [String] = []
        var regex = ""
        words.map {
            regex = "(.*\\b\($0)\\b.*|\\b\($0).*)"
            regex += ""
        }
        return regex
//        if let range = str_ddlj.range(of:regexp_ddlj, options: [.regularExpression,.caseInsensitive]) {
//            print("this string contains hum le \(range)")
//        } else {
//            print(##"this string doesn't have the "le" we want"##)
//        }
        //let regexp_ddlj = "(.*\\bram\\b.*|\\bt.*)"
    }
}

extension NowPlayingViewModel {
    func fetch(at page: Int, handler: @escaping ([MovieModel]) -> Void) {
        onChange?(state.setFetching(fetching: true))
        let request = FetchUpcomingMoviesRequest(page: page)
        RequestManager.shared.perform(request) {[weak self] (apiResponse: ApiResponse<MoviesResponseModel>) in
            guard let slf = self else {return}
            switch apiResponse.result {
            case .success(let successValue):
                print("==> ViewModel Success")
                guard let movies = successValue.results,
                    let currentPage = successValue.page,
                    let totalPage = successValue.totalPages else {
                        slf.onChange?(.error(.mappingFailed))
                        return
                }
                let page = PageInfo(current: currentPage, total: totalPage)
                slf.state.update(page: page)
                handler(movies)
            case .failure(let failure):
                print("==> ViewModel Failure")
                slf.onChange?(.error(.connectionError(failure)))
            }
        }
        
    }
}
