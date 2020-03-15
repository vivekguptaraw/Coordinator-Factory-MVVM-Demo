//
//  StoryboardLoadableProtocol.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 29/02/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit

protocol StoryboardLoadableProtocol {
    static var defaultStoryboardName: String { get }
    static var defalutViewControllerId: String { get }
    static func loadFromStoryboard() -> Self
}

extension StoryboardLoadableProtocol where Self: UIViewController {
    static var defalutViewControllerId: String {
        return String(describing: self)
    }
    
    static func loadFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: defaultStoryboardName, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: defalutViewControllerId) as? Self else {
            fatalError("[StoryboardLoadable] Cannot instantiate view controller from storyboard.")
        }
        
        return viewController
    }
}
