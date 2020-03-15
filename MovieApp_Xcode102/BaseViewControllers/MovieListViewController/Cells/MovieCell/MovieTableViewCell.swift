//
//  MovieTableViewCell.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 01/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: BaseTableViewCell, InstantiableProtocol, NibLoadableProtocol {
    
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var releaseDateLabel: UILabel!
    @IBOutlet fileprivate weak var overviewLabel: UILabel!
    @IBOutlet fileprivate weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.assignActivityIndicator()
        }
    }

    override var viewBindableModel: ViewBindableProtocol? {
        didSet {
            guard let bindable = viewBindableModel else {
                return
            }
            titleLabel.text = bindable.getTitle()
            releaseDateLabel.text = bindable.getSubtitle()
            overviewLabel.text = bindable.getSubText()
            if let url = bindable.getImageURL(size: .​w185) {
                posterImageView.kf.setImage(with: url)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.contentMode = .center
        styleSetUp()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.layer.cornerRadius = posterImageView.frame.width / 2
        posterImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        releaseDateLabel.text = nil
        overviewLabel.text = nil
        posterImageView.image = nil
        posterImageView.kf.cancelDownloadTask()
    }
    
}

extension MovieTableViewCell {
    func styleSetUp() {
        posterImageView.layer.borderWidth = 0.3
        posterImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
}
