//
//  SimilarMovieSource.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 10/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit

class SimilarMovieDataSource: CollectionArrayDataSource<MovieModel, SimilarMovCollectionViewCell> {}

class CastsDataSource: CollectionArrayDataSource<Cast, CastCollectionViewCell> {
    var movieModel: MovieModel?
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        if let castCell = cell as? CastCollectionViewCell, let model = movieModel {
            castCell.setMovieModel(model: model)
        }
        return cell
        
    }
}

class CrewDataSource: CollectionArrayDataSource<Crew, CrewCollectionViewCell> {}
