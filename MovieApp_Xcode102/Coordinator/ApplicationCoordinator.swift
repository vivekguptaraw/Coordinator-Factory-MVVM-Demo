//
//  ApplicationCoordinator.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 07/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    
    private let router: Router
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
    init(router: Router, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start(with option: DeeplinkPath?) {
        if option == nil {
            self.runSplashFlow()
        } else {
            // We got some deeplink within app OR from Launching option OR We can simply route the User to show some default Eula/OnBoarding screen
            
        }
    }
    
    private func runSplashFlow() {
        var coordinator = coordinatorFactory.makeSplashCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.showNowPlayingAsRootScreen()
            self?.removeDependency(coordinator)
        }
        
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func showNowPlayingAsRootScreen() {
        var cordinator = coordinatorFactory.makeNowPlayingCoordinator(router: router)
        cordinator.finishFlow = { [weak self, weak cordinator] in
            self?.removeDependency(cordinator)
        }
        addDependency(cordinator)
        cordinator.start()
    }
    
}
