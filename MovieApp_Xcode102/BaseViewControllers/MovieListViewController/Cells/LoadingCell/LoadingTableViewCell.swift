//
//  LoadingTableViewCell.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 01/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit

class LoadingTableViewCell: BaseTableViewCell, NibLoadableProtocol, InstantiableProtocol {
    
    override func awakeFromNib() {
        selectionStyle = .none
    }
    
}
