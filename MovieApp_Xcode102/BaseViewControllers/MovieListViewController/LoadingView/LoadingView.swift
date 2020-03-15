//
//  LoadingView.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 01/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit

class LoadingView: UIView, NibLoadableProtocol, InstantiableProtocol {
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    @IBOutlet weak var loadingLable: UILabel!
    
    override func awakeFromNib() {
        loadingView.layer.cornerRadius = 5
        loadingView.backgroundColor = .clear
        loadingLable.textColor = .black
        activityInd.color = .black
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: loadingView.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: loadingView.widthAnchor),
            ])
    }
    
}
