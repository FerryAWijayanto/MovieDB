//
//  HomeVC.swift
//  MovieDB
//
//  Created by Ferry Adi Wijayanto on 30/11/21.
//

import UIKit

class HomeVC: UIViewController {
    
    enum Section { case main }
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, MovieItem>!
    
    var populars: [MovieItem] = []
    
    private let service = NetworkDataFetcher(service: NetworkService())
    private let viewModel = PopularViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
}

extension HomeVC {
    
    private func initialize() {
        showLoadingView()
        viewModel.fetchPopularMovies()
        viewModel.stopLoading = {
            self.dismissLoadingView()
        }
        
        viewModel.reloadMovie = { [weak self] movies in
            guard let self = self else { return }
            self.updateData(on: movies)
        }
        
        viewModel.errorConnectionMessage = { [weak self] message in
            guard let self = self else { return }
            self.alertMessage(title: "Error", message: message, buttonTitle: "Dismiss")
        }
        
        viewModel.errorMessage = { [weak self] message in
            guard let self = self else { return }
            self.alertMessage(title: "Error", message: message, buttonTitle: "Dismiss")
        }
        
        setupCollectionView()
        setupCollectionViewDataSource()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createCollectionViewFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.reuseID)
        collectionView.backgroundColor = .systemBackground
    }
    
    private func setupCollectionViewDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, MovieItem>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.reuseID, for: indexPath) as! PopularCell
            cell.set(movie: movie)
            
            return cell
        })
    }
    
    private func updateData(on movies: [MovieItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MovieItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let popularMovie = viewModel.didSelectItem(at: indexPath)
        let movieDetailVC = MovieDetailVC()
        movieDetailVC.title = popularMovie.title
        movieDetailVC.movie = popularMovie
        
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentY            = scrollView.contentOffset.y
        let height              = scrollView.contentSize.height
        let scrollViewHeight    = scrollView.frame.size.height
        
        if contentY > height - scrollViewHeight {
            guard viewModel.hasMoreMovies else { return }
            viewModel.currentPage += 1
            showLoadingView()
            viewModel.fetchPopularMovies(page: viewModel.currentPage)
            viewModel.stopLoading = {
                self.dismissLoadingView()
            }
            
            viewModel.reloadMovie = { [weak self] movies in
                guard let self = self else { return }
                self.updateData(on: movies)
            }
        }
    }
}
