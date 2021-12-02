//
//  ReviewCell.swift
//  MovieDB
//
//  Created by Ferry Adi Wijayanto on 30/11/21.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    static let id = "ReviewCell"
    
    private let authorImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "movieDB placeholder")
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        return iv
    }()
    
    private let authorLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let ratingLbl: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let reviewLbl: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    func set(review: ReviewItem) {
        let imageUrl = review.authorDetails?.avatarPath
        if imageUrl?.contains("https") == true {
            authorImageView.image = UIImage(named: "movieDB placeholder")
        } else {
            authorImageView.loadImage(from: imageUrl ?? "")
        }
        
        guard let rating = review.authorDetails?.rating else { return }
        authorLbl.text = review.author
        ratingLbl.text = "Ratings: \(rating)"
        reviewLbl.text = review.content
    }
    
    private func configure() {
        [authorImageView, authorLbl, ratingLbl, reviewLbl].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
        }
        
        NSLayoutConstraint.activate([
            authorImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            authorImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            authorImageView.widthAnchor.constraint(equalToConstant: 40),
            authorImageView.heightAnchor.constraint(equalToConstant: 40),
            
            authorLbl.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            authorLbl.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 8),
            authorLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            authorLbl.heightAnchor.constraint(equalToConstant: 20),
            
            ratingLbl.topAnchor.constraint(equalTo: authorLbl.bottomAnchor, constant: 4),
            ratingLbl.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 8),
            ratingLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            ratingLbl.heightAnchor.constraint(equalToConstant: 20),
            
            reviewLbl.topAnchor.constraint(equalTo: authorImageView.bottomAnchor, constant: 16),
            reviewLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            reviewLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            reviewLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
