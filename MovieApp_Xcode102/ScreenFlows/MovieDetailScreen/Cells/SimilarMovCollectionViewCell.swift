//
//  SimilarMovCollectionViewCell.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 09/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit
import Kingfisher

class SimilarMovCollectionViewCell: UICollectionViewCell, ConfigurableCell {
  
    typealias T = MovieModel
    
    @IBOutlet weak var bgImageVw: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func configure(_ item: MovieModel, at indexPath: IndexPath) {
        if let url = item.getImageURL(size: .​w500) {
            bgImageVw.kf.setImage(with: url)
        }
        titleLabel.text = item.getTitle()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundedCornerAll(radius: 6)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.bgImageVw.image = nil
    }
    
}
