//
//  NowPlayingCoordiator.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 08/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

final class NowPlayingCoordiator: BaseCoordinator, NowPlayingCoordinatorOutput {
    var finishFlow: (() -> Void)?
    private let factory: NowPlayingModuleFactory
    private let router: Router
    
    init(with factory: NowPlayingModuleFactory, router: Router) {
        self.factory = factory
        self.router = router
    }
    
    override func start() {
        showNowPlayingScreen()
    }
    
    func showNowPlayingScreen() {
        let nowPlayingModule = factory.makeNowPlayingModule()
        nowPlayingModule.onItemSelect = { [weak self] (movieModel) in
            self?.showMovieDetail(movieModel: movieModel)
        }
        router.setRootModule(nowPlayingModule, hideBar: false)
    }
    
    func showMovieDetail(movieModel: MovieModel) {
        let movieDetailModule = factory.showMovieDetailScreen(movieId: movieModel)
        router.push(movieDetailModule, animated: true)
    }

}


