//
//  PopularViewModel.swift
//  MovieDB
//
//  Created by Ferry Adi Wijayanto on 30/11/21.
//

import Foundation

class PopularViewModel {
    
    private var populars: [MovieItem] = []
    var currentPage = 1
    var hasMoreMovies = true
    
    var reloadMovie: (([MovieItem]) -> Void)?
    var errorConnectionMessage: ((String) -> Void)?
    var errorMessage: ((String) -> Void)?
    var startLoading: (() -> Void)?
    var stopLoading: (() -> Void)?
    
    private let service: NetworkDataFetcher
    
    init(service: NetworkDataFetcher = NetworkDataFetcher(service: NetworkService())) {
        self.service = service
    }
    
    func didSelectItem(at indexPath: IndexPath) -> MovieItem {
        populars[indexPath.row]
    }
    
    func fetchPopularMovies(page: Int = 1) {
        service.getDiscover(page: page) { [weak self] results in
            guard let self = self else { return }
            self.stopLoading?()
            switch results {
            case .success(let movies):
                if movies.count < 20 { self.hasMoreMovies = false }
                self.populars.append(contentsOf: movies)
                
                if movies.isEmpty {
                    let message = "Something went wrong check your internet connection."
                    DispatchQueue.main.async { self.errorConnectionMessage?(message) }
                }
                self.reloadMovie?(self.populars)
            case .failure(let error):
                self.errorMessage?(error.rawValue)
            }
        }
    }
    
}
