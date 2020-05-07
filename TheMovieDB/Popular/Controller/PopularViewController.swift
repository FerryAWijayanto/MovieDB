//
//  PopularViewController.swift
//  TheMovieDB
//
//  Created by Ferry Adi Wijayanto on 06/05/20.
//  Copyright © 2020 Ferry Adi Wijayanto. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController {

    var collectionView: UICollectionView!
    var timer: Timer?
    var page = 1
    var hasMoreMovies = true
    let store = PopularStore()
    let dataSource = PopularDataSource()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupCollectionView()
        fetchMovie(page: page)
    }
    
    private func fetchMovie(page: Int) {
        showLoadingView()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.store.fetchMovie(page: page, completion: { [weak self] result in
                guard let self = self else { return }
                self.dismissLoadingView()
                switch result {
                case .success(let movies):
                    if movies.count < 100 { self.hasMoreMovies = false }
                    self.dataSource.items.append(contentsOf: movies)
                case .failure(let error):
                    self.dataSource.items.removeAll()
                    print(error)
                }
                self.collectionView.reloadSections(IndexSet(integer: 0))
            })
        })
    }

    private func setupNavigation() {
        view.backgroundColor = .white
        title = NavigationTitle.movies.rawValue
        navigationItem.searchController = searchController
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createTwoColumnLayout(in: self.view))
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.cellID)
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PopularViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let movie = dataSource.items[indexPath.row]
        
        store.fetchImage(for: movie, completion: { [weak self] result in
            guard let self = self else { return }
            
            guard
                let movieIndex = self.dataSource.items.firstIndex(of: movie),
                case let .success(image) = result else {
                    return
            }
            let movieIndexPath = IndexPath(item: movieIndex, section: 0)
            
            if let cell = self.collectionView.cellForItem(at: movieIndexPath) as? PopularCell {
                cell.update(with: image)
                cell.updateResult(with: movie)
            }
        })
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        store.paginateMovie(in: scrollView) {
            guard self.hasMoreMovies else { return }
            self.page += 1
            self.fetchMovie(page: self.page)
        }
    }
}

extension PopularViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            dataSource.items = dataSource.items.filter({ ($0.title.lowercased().contains(searchText.lowercased()))})
        } else {
            dataSource.items = dataSource.items
        }
        self.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dataSource.items.removeAll()
        fetchMovie(page: 1)
    }
}
