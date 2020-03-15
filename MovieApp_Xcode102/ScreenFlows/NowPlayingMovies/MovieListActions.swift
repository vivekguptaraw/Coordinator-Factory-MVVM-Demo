//
//  MovieListActions.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 08/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import Foundation
protocol MovieListActions: BaseView {
    var onItemSelect: ((MovieModel) -> ())? { get set }
}
