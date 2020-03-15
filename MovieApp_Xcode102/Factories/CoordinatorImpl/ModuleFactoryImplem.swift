//
//  ModuleFactoryImplem.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 08/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

final class ModuleFactoryImplem: SplashModuleFactory, NowPlayingModuleFactory {
    
    func showSplashScreen() -> Presentable {
        return SplashViewController.controllerFromStoryboard(.splash)
    }
    
    func makeNowPlayingModule() -> MovieListActions {
        let vc = NowPlayingViewController.controllerFromStoryboard(.nowPlaying)
        vc.viewModel = NowPlayingViewModel()
        return vc
    }
    
    func showMovieDetailScreen(movieId: MovieModel) -> BaseView {
        let controller = MovieDetailViewController.controllerFromStoryboard(.movieDetail)
        controller.movieModel = movieId
        controller.viewModel = MovieDetailViewModel(movieModel: movieId)
        return controller
    }
    
    
}
