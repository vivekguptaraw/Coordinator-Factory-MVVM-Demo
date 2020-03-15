//
//  MovieViewModel.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 01/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

struct MovieListState {
    fileprivate(set) var moviesArray: [MovieModel] = []
    fileprivate(set) var page = PageInfo(current: 1, total: 1)
    fileprivate(set) var isFetching = false
    fileprivate(set) var isSearchInProgress =  false
    fileprivate(set) var filteredArray: [MovieModel]?
}

extension MovieListState {
    enum ChangeStateForList {
        case none
        case fetchStateChanged
        case error(MovieListError)
        case moviesChanged(CollectionChange)
        case searching
        case searchResultFetched(CollectionChange)
    }
    
    mutating func setFetching(fetching: Bool) -> ChangeStateForList {
        self.isFetching = fetching
        return .fetchStateChanged
    }
    
    mutating func reload(movies: [MovieModel]) -> ChangeStateForList {
        self.moviesArray = movies
        return .moviesChanged(.reload)
    }
    
    mutating func insert(movies: [MovieModel]) -> ChangeStateForList {
        let index = self.moviesArray.count
        self.moviesArray.append(contentsOf: movies)
        let range = IndexSet(integersIn: index..<self.moviesArray.count)
        return .moviesChanged(.insertion(range))
    }
    
    mutating func update(page: PageInfo) {
        self.page = page
        print("==> currentPage fetched \(self.page.currentPage)")
    }
    
    mutating func setSearchFetching(searching: Bool) -> ChangeStateForList {
        self.isSearchInProgress = searching
        return .searching
    }
    
    mutating func setSearchMoviesArray(movies: [MovieModel]) -> ChangeStateForList {
        self.filteredArray = movies
        return .searchResultFetched(.reload)
    }
    
}

enum MovieListError {
    case connectionError(Error)
    case mappingFailed
    case reloadFailed
}

protocol MovieViewModel {
    var state: MovieListState { get }
    var onChange: ((MovieListState.ChangeStateForList) -> Void)? { get set}
    
    func reloadMovies()
    func loadMoreMovies()
    func searchMovies(text: String)
}
