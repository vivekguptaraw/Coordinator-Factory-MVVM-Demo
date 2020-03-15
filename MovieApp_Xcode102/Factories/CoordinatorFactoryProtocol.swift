//
//  CoordinatorFactoryProtocol.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 08/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

protocol CoordinatorFactoryProtocol {
    func makeSplashCoordinator(router: Router) -> Coordinator & SplashCoordinatorOutput
    func makeNowPlayingCoordinator(router: Router) -> Coordinator & NowPlayingCoordinatorOutput
    
}
