//
//  CrewCollectionViewCell.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 10/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit
import Kingfisher

class CrewCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    typealias T = Crew
    
    @IBOutlet weak var creditImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var departmentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ item: Crew, at indexPath: IndexPath) {
        if let url = item.getImageURL(size: .​w185) {
            creditImageView.kf.setImage(with: url)
        }
        if let name = item.name {
            self.nameLabel.text = name
        }
        if let dept = item.department {
            self.departmentLabel.text = dept
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundedCornerAll(radius: 6)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.creditImageView.image = nil
    }

}
