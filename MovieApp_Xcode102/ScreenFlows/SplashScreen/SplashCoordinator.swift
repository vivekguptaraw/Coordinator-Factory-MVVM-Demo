//
//  SplashCoordinator.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 08/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation

final class SplashCoordinator: BaseCoordinator, SplashCoordinatorOutput {
    var finishFlow: (() -> Void)?
    private let router: Router
    private let factory: SplashModuleFactory
    
    init(router: Router, factory: SplashModuleFactory) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        let splashFactory = factory.showSplashScreen()
        DispatchQueue.main.async {[weak self] in
            self?.finishFlow?()
        }
        router.setRootModule(splashFactory)
    }
    
    func showNowPlaying() {
        
    }
    
}
