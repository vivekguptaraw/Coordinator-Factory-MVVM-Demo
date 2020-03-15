//
//  MovieDetailViewController.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 06/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController, BaseView {
    
    @IBOutlet weak var topImageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var parentTopView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    @IBOutlet weak var crewCollectionView: UICollectionView!
    @IBOutlet weak var similarMoviesCollectionView: UICollectionView!
    
    @IBOutlet weak var castViewHeight: NSLayoutConstraint!
    @IBOutlet weak var crewViewHeight: NSLayoutConstraint!
    @IBOutlet weak var similarViewHeight: NSLayoutConstraint!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    
    var movieModel: MovieModel?
    var synopsis: MovieSynopsisModel?
    var reviews: [MovieReviewModel]?
    var credits: MovieCreditsModel?
    var similarMovies: [MovieModel]?
    var viewModel: MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.contentInset = UIEdgeInsets(top: self.topImageView.frame.height - 40, left: 0, bottom: 0, right: 0)
        self.setInitialData()
        self.bindViewModel()
        self.similarMoviesCollectionView.register(SimilarMovCollectionViewCell.defaultNib, forCellWithReuseIdentifier: SimilarMovCollectionViewCell.defaultNibName)
        self.castCollectionView.register(CastCollectionViewCell.defaultNib, forCellWithReuseIdentifier: CastCollectionViewCell.defaultNibName)
        self.crewCollectionView.register(CrewCollectionViewCell.defaultNib, forCellWithReuseIdentifier: CrewCollectionViewCell.defaultNibName)
        guard let tl = movieModel?.getTitle() else {return}
        self.title = tl
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.parentTopView.roundCorners(corners: [.topRight, .topLeft], radius: 20)
    }
    
    func setInitialData() {
        guard let model = movieModel else { return }
        if let url = model.getImageURL(size: .​w500) {
            topImageView.kf.setImage(with: url)
        }
        self.titleLabel.text = model.getTitle()
        self.overViewLabel.text = model.getSubText()
    }
    
    func bindViewModel() {
        self.viewModel.onFetched = self.movieDetailStateChanged
        self.viewModel.loadSynopsis()
        self.viewModel.loadReviews()
        self.viewModel.loadCredits()
        self.viewModel.loadSimilarMovies()
        
    }
    
    func movieDetailStateChanged(change: MovieDetailState.ChangeStateForMovieDetail) {
        switch change {
        case .synopsysFetched:
            self.synopsis = viewModel.state.synopsis
        case .reviewsFetched:
            self.reviews = viewModel.state.reviews?.results
            self.showReviews()
        case .creditsFetched:
            self.credits = viewModel.state.credits
            self.reloadCast()
            self.reloadCrews()
        case .similarMoviesFetched:
            self.similarMovies = viewModel.state.similarMovies?.results
            self.reloadSimilarMovies()
        default:
            return
        }
    }
    
    func showReviews() {
        guard let rev = self.reviews, rev.count > 0 else{
            self.reviewsLabel.text = "Reviews : No Reviews"
            return
        }
        let txt = rev.count > 1 ? "\(rev.count) Reviews" : "\(rev.count) Review"
        self.reviewsLabel.text = "Reviews : \(txt)"
    }
    
    func reloadCast() {
        if let casts = viewModel.state.credits?.cast, casts.count > 0 {
            self.viewModel.castMovieDataSource = CastsDataSource(collectionView: self.castCollectionView, array: casts)
            self.viewModel.castMovieDataSource?.movieModel = self.movieModel
            self.setLayout(collectionVw: self.castCollectionView, isSquare: true)
        } else {
            castViewHeight.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func reloadCrews() {
        if let crews = viewModel.state.credits?.crew, crews.count > 0 {
            self.viewModel.crewMovieDataSource = CrewDataSource(collectionView: self.crewCollectionView, array: crews)
            self.setLayout(collectionVw: self.crewCollectionView, isSquare: true)
        } else {
            crewViewHeight.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func reloadSimilarMovies() {
        guard let models = viewModel.state.similarMovies?.results, models.count > 0 else {
            similarViewHeight.constant = 0
            self.view.layoutIfNeeded()
            return
        }
        self.viewModel.similarMovieDataSource = SimilarMovieDataSource(collectionView: self.similarMoviesCollectionView, array: models)
            self.setLayout(collectionVw: self.similarMoviesCollectionView)
    }
    
    func setLayout(collectionVw: UICollectionView, isSquare: Bool = false) {
        guard let layout = collectionVw.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let itemW = UIScreen.main.bounds.width * 0.33
        let itemH = isSquare ? itemW : self.similarMoviesCollectionView.frame.height
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .horizontal
        layout.invalidateLayout()
    }

}
