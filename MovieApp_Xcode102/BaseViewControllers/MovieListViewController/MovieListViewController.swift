//
//  MovieListViewController.swift
//  MovieApp_Xcode102
//
//  Created by Vivek Gupta on 01/03/20.
//  Copyright © 2020 Vivek Gupta. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, MovieListActions {
    var onItemSelect: ((MovieModel) -> ())?

    fileprivate enum CellHeight {
        static let contentCellHeight: CGFloat = 200
        static let loadingCellHeight: CGFloat = 44
    }
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    var viewModel: MovieViewModel!
    weak var refreshControl: UIRefreshControl?
    var loadingView = LoadingView.instantiate()
    var emptyLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.reloadMovies()
        self.bindViewModel()
        self.setUpSearchBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loadingView.center = view.center
        self.tableView.tableFooterView = UIView()
    }
    
    func viewModelStateChange(change: MovieListState.ChangeStateForList) {
        switch change {
        case .none:
            break
        case .fetchStateChanged:
            if !viewModel.state.moviesArray.isEmpty {
                loadingView.isHidden = true
                break
            }
            loadingView.isHidden = !viewModel.state.isFetching
            break
        case .moviesChanged(let collectionChange):
            switch collectionChange {
            case .reload:
                tableView.applyCollectionChange(collectionChange, toSection: PaginationSection.content.rawValue, withAnimation: .fade)
            default:
                tableView.beginUpdates()
                if !viewModel.state.page.hasNextPage {
                    tableView.applyCollectionChange(.deletion(0), toSection: PaginationSection.content.rawValue, withAnimation: .fade)
                }
                tableView.applyCollectionChange(collectionChange, toSection: PaginationSection.content.rawValue, withAnimation: .fade)
                tableView.endUpdates()
            }
            break
        case .error(let listError):
            switch listError {
            case .connectionError(_):
                print("Connection Error")
            case .mappingFailed:
                print("Mapping failed Error")
            case .reloadFailed:
                print("ReloadFailed Error")
            }
            break
        case .searching:
            if !viewModel.state.moviesArray.isEmpty {
                loadingView.isHidden = true
                break
            }
            loadingView.isHidden = !viewModel.state.isFetching
            break
        case .searchResultFetched(let collChange):
            switch collChange {
            case .reload :
                tableView.applyCollectionChange(collChange, toSection: PaginationSection.content.rawValue, withAnimation: .fade, completion: {[weak self] in
                    guard let slf = self else {return}
                    slf.scroll()
                    slf.showEmptyView()
                })
                
            default :
                break
            }
            
        }
    }
    
    func scroll() {
        guard let indexPaths = self.tableView.indexPathsForVisibleRows, let first = indexPaths.first else {return}
        tableView.scrollToRow(at: first, at: .middle, animated: false)
    }
    
    func showEmptyView() {
        guard let filtered = viewModel.state.filteredArray else {
            return}
        if filtered.count == 0 {
            emptyLabel.textAlignment = .center
            emptyLabel.text = "Sorry.. No Results Found."
            tableView.backgroundView = emptyLabel
        } else {
            emptyLabel.text = nil
            tableView.backgroundView = nil
        }
    }
    
}

extension MovieListViewController {
    func setupUI() {
        self.tableView.register(MovieTableViewCell.defaultNib, forCellReuseIdentifier: MovieTableViewCell.defaultReuseIdentifier)
        self.tableView.register(LoadingTableViewCell.defaultNib, forCellReuseIdentifier: LoadingTableViewCell.defaultReuseIdentifier)
        
        view.addSubview(loadingView)
        view.bringSubviewToFront(loadingView)
        loadingView.center = view.center
        loadingView.isHidden = true
    }
    
    func bindViewModel() {
        self.viewModel.onChange = self.viewModelStateChange
    }
    
    func reloadMovies() {
        viewModel.reloadMovies()
    }
    
    func setUpSearchBar() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
            let searchController = UISearchController(searchResultsController: nil)
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            searchController.searchBar.placeholder = "Now Playing.."
            searchController.searchBar.tintColor = .orange
            searchController.dimsBackgroundDuringPresentation = false
            searchController.searchResultsUpdater = self
            definesPresentationContext = true
        }
    }
}

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            self.viewModel.searchMovies(text: searchText)
        }
        
    }
}

extension MovieListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return PaginationSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pageSection = PaginationSection(rawValue: section) else {
            return 0
        }
        switch pageSection {
        case .content:
            if viewModel.state.isSearchInProgress {
                guard let filterd = viewModel.state.filteredArray else {return 0}
                return filterd.count
            }
            return viewModel.state.moviesArray.count
        case.loading:
            if viewModel.state.isSearchInProgress {
                return 0
            }
            return viewModel.state.page.hasNextPage ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pageSection = PaginationSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch pageSection {
        case .content:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.defaultReuseIdentifier, for: indexPath) as? MovieTableViewCell else {
                return UITableViewCell()
            }
            if viewModel.state.isSearchInProgress {
                guard let filterd = viewModel.state.filteredArray else {return UITableViewCell()}
                let movie = filterd[indexPath.row]
                cell.viewBindableModel = movie
                return cell
            }
            let movie = viewModel.state.moviesArray[indexPath.row]
            cell.viewBindableModel = movie
            return cell
        case .loading:
            if viewModel.state.isSearchInProgress {
                return UITableViewCell()
            }
            return tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.defaultReuseIdentifier,
                                                 for: indexPath)
        }
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let pageSection = PaginationSection(rawValue: indexPath.section) else { return }
        if pageSection == .content {
            if viewModel.state.page.hasNextPage {
                if indexPath.row == (viewModel.state.moviesArray.count - PaginationSection.offset) {
                    viewModel.loadMoreMovies()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieModel = viewModel.state.moviesArray[indexPath.row]
        self.onItemSelect?(movieModel)
    }
}
