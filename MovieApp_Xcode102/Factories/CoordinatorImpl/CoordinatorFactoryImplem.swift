//
//  CoordinatorFactoryImplem.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 08/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

final class CoordinatorFactoryImplem: CoordinatorFactoryProtocol {
    func makeSplashCoordinator(router: Router) -> Coordinator & SplashCoordinatorOutput {
        let coordinator = SplashCoordinator(router: router, factory: ModuleFactoryImplem())
        return coordinator
    }
    
    func makeNowPlayingCoordinator(router: Router) -> Coordinator & NowPlayingCoordinatorOutput {
        let coordinator = NowPlayingCoordiator(with: ModuleFactoryImplem(), router: router)
        return coordinator
    }
}
