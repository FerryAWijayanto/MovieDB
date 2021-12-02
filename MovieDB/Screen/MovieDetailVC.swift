//
//  MovieDetailVC.swift
//  MovieDB
//
//  Created by Ferry Adi Wijayanto on 30/11/21.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    var collectionView: UICollectionView!
    var tableView: UITableView!
    
    var movie: MovieItem!
    
    private let viewModel = ReviewViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
}

private extension MovieDetailVC {
    func initialize() {
        showLoadingView()
        viewModel.getReviews(id: movie.id)
        viewModel.getVideos(id: movie.id)
        viewModel.reloadData = {
            self.dismissLoadingView()
            self.tableView.reloadData()
        }
        
        viewModel.errorMessage = { [weak self] message in
            guard let self = self else { return }
            self.alertMessage(title: "Error", message: message, buttonTitle: "Dismiss")
        }
        setupTableView()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.id)
        
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 420))
        headerView.set(movie: movie)
        
        viewModel.getVideo = { videos in
            guard let video = videos.first?.key else { return }
            headerView.videoView.load(withVideoId: video)
        }
        
        let footerView = EmptyView()
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
    }
}

extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.id) as! ReviewCell
        let review = viewModel.cellForItem(at: indexPath)
        cell.set(review: review)
        return cell
    }
}
