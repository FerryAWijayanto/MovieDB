//
//  HeaderView.swift
//  MovieDB
//
//  Created by Ferry Adi Wijayanto on 30/11/21.
//

import UIKit
import youtube_ios_player_helper

class HeaderView: UIView {
    static let id = "HeaderView"
    
    let videoView: YTPlayerView = {
       let v = YTPlayerView()
        return v
    }()
    
    private let movieLbl: UILabel = {
        let label = UILabel()
        label.text = "Movie Title"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let releaseDateLbl: UILabel = {
       let label = UILabel()
        label.text = "release date"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let overviewLbl: UILabel = {
       let label = UILabel()
        label.text = "overview"
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let reviewLbl: UILabel = {
       let label = UILabel()
        label.text = "Reviews"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    private let separationView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray5
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: MovieItem) {
        movieLbl.text = movie.title
        releaseDateLbl.text = movie.releaseDate
        overviewLbl.text = movie.overview
    }
    
    private func configure() {
        let stackView = UIStackView(arrangedSubviews: [movieLbl, releaseDateLbl, overviewLbl])
        stackView.distribution = .fill
        stackView.axis = .vertical
        
        [videoView, stackView, reviewLbl, separationView].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
        }
        
        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: topAnchor),
            videoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            videoView.heightAnchor.constraint(equalToConstant: 200),
            
            movieLbl.heightAnchor.constraint(equalToConstant: 20),
            releaseDateLbl.heightAnchor.constraint(equalToConstant: 20),
            
            stackView.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: reviewLbl.topAnchor),
            
            reviewLbl.bottomAnchor.constraint(equalTo: separationView.topAnchor, constant: -4),
            reviewLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            reviewLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            reviewLbl.heightAnchor.constraint(equalToConstant: 20),
            
            separationView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separationView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
