//
//  CastCollectionViewCell.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 10/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    typealias T = Cast
    var movieModel: MovieModel?
    
    @IBOutlet weak var castImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ item: Cast, at indexPath: IndexPath) {
        if let url = item.getImageURL(size: .​w185) {
            castImageView.kf.setImage(with: url)
        }
        if let name = item.name {
            self.nameLabel.text = name
        }
    }
    
    func setMovieModel(model: MovieModel) {
        self.movieModel = model
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundedCornerAll(radius: 6)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.castImageView.image = nil
    }

}
