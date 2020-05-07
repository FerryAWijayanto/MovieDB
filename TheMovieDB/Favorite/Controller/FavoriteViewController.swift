//
//  FavoriteViewController.swift
//  TheMovieDB
//
//  Created by Ferry Adi Wijayanto on 06/05/20.
//  Copyright © 2020 Ferry Adi Wijayanto. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    private let favoriteKey = "favoriteMovieKey"
    
    let store = PopularStore()
    let dataSource = FavoriteDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()        
        
        setupNavigation()
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let movie = UserDefaults.standard.retrieve(object: Movie.self, fromKey: "favoriteMovieKey") {
            dataSource.items.append(movie)
            tableView.reloadData()
        }
    }
    
    private func setupNavigation() {
        view.backgroundColor = .white
        navigationItem.title = NavigationTitle.favorite.rawValue
        navigationItem.searchController = searchController
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        definesPresentationContext = true
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.cellID)
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.rowHeight = 130
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension FavoriteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let movie = dataSource.items[indexPath.row]
        
        store.fetchImage(for: movie) { [weak self] result in
            guard let self = self else { return }
            
            guard
                let movieIndex = self.dataSource.items.firstIndex(of: movie),
                case let .success(image) = result else {
                    return
            }
            let movieIndexPath = IndexPath(item: movieIndex, section: 0)
            
            if let cell = self.tableView.cellForRow(at: movieIndexPath) as? FavoriteCell {
                cell.update(with: image)
                cell.updateResult(with: movie)
            }
        }
    }
}

extension FavoriteViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}
