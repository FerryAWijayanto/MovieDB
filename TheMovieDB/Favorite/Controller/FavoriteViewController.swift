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
    
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()        
        
        setupNavigation()
        setupTableView()
        
        guard let data = UserDefaults.standard.data(forKey: "favoriteMovieKey") else { return }
        do {
            if let movie = try NSKeyedUnarchiver(forReadingFrom: data) as? Movie {
                movies.append(movie)
                tableView.reloadData()
            }
        } catch {
            print("Failed to unarchive data")
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
        tableView.dataSource = self
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

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.cellID, for: indexPath) as! FavoriteCell
        
        return cell
    }
}

extension FavoriteViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}
