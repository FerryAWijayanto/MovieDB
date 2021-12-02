//
//  PopularCell.swift
//  MovieDB
//
//  Created by Ferry Adi Wijayanto on 30/11/21.
//

import UIKit

class PopularCell: UICollectionViewCell {
    
    static let reuseID = "PopularCell"

    private let movieImageView: UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius   = 10
        iv.clipsToBounds        = true
        iv.image                = UIImage(named: "movieDB placeholder")
        iv.contentMode          = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let movieLbl: UILabel = {
       let lbl = UILabel()
        lbl.textColor                                   = .label
        lbl.adjustsFontSizeToFitWidth                   = true
        lbl.minimumScaleFactor                          = 0.9
        lbl.lineBreakMode                               = .byTruncatingTail
        lbl.textAlignment                               = .center
        lbl.font                                        = UIFont.systemFont(ofSize: 16, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints   = false
        return lbl
    }()
    
    fileprivate let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: MovieItem) {
        movieImageView.loadImage(from: movie.posterPath)
        movieLbl.text = movie.title
    }
    
    private func configure() {
        addSubview(movieImageView)
        addSubview(movieLbl)
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            movieImageView.heightAnchor.constraint(equalToConstant: 110),
            
            movieLbl.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: padding),
            movieLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            movieLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            movieLbl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
