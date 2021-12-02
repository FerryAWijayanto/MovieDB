//
//  ReviewViewModel.swift
//  MovieDB
//
//  Created by Ferry Adi Wijayanto on 30/11/21.
//

import Foundation

class ReviewViewModel {
    
    private var reviews: [ReviewItem] = []
    private var videos: [VideoItem] = []
    
    var reloadData: (() -> Void)?
    var getVideo: (([VideoItem]) -> Void)?
    var errorMessage: ((String) -> Void)?
    
    private let service: NetworkDataFetcher
    
    init(service: NetworkDataFetcher = NetworkDataFetcher(service: NetworkService())) {
        self.service = service
    }
    
    func getReviews(id: Int) {
        service.getReviews(withID: id) { [weak self] results in
            guard let self = self else { return }
            switch results {
            case .success(let reviews):
                self.reviews = reviews
                self.reloadData?()
            case .failure(let error):
                self.errorMessage?(error.rawValue)
            }
        }
    }
    
    func getVideos(id: Int) {
        service.getVideos(withID: id) { [weak self] results in
            guard let self = self else { return }
            switch results {
            case .success(let videos):
                self.videos = videos
                self.getVideo?(self.videos)
                self.reloadData?()
            case .failure(let error):
                self.errorMessage?(error.rawValue)
            }
        }
    }
    
    func numberOfItemsInSection() -> Int {
        reviews.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> ReviewItem {
        reviews[indexPath.row]
    }
}
