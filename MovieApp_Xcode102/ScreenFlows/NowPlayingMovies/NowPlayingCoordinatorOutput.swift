//
//  NowPlayingCoordinatorOutput.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 08/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

protocol NowPlayingCoordinatorOutput {
    var finishFlow: (() -> Void)? {get set}
}
