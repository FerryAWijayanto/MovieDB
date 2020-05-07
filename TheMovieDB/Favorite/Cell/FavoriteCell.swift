//
//  FavoriteCell.swift
//  TheMovieDB
//
//  Created by Ferry Adi Wijayanto on 06/05/20.
//  Copyright © 2020 Ferry Adi Wijayanto. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let cellID = "FavoriteCell"

    let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Day 1").withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    let movieTitleLbl: UILabel = {
        let label = UILabel()
        label.text = "John Wick"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    let releaseLbl: UILabel = {
        let label = UILabel()
        label.text = "2018"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    let descriptionLbl: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups."
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        update(with: nil)
        updateResult(with: nil)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(with image: UIImage?) {
        if let imageToDisplay = image {
            movieImageView.image = imageToDisplay
        } else {
            movieImageView.image = nil
        }
    }

    func updateResult(with movie: Movie?) {
        if let movieToDisplay = movie {
            movieTitleLbl.text = movieToDisplay.title
            releaseLbl.text = movieToDisplay.releaseDate
            descriptionLbl.text = movieToDisplay.overview
        }
    }

    private func configure() {
        [movieImageView, movieTitleLbl, releaseLbl, descriptionLbl].forEach({ v in
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
        })
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
            
            movieTitleLbl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            movieTitleLbl.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            movieTitleLbl.trailingAnchor.constraint(equalTo: releaseLbl.leadingAnchor, constant: 10),
            movieTitleLbl.heightAnchor.constraint(equalToConstant: 20),
            
            releaseLbl.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            releaseLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            releaseLbl.widthAnchor.constraint(equalToConstant: 50),
            releaseLbl.heightAnchor.constraint(equalToConstant: 20),
            
            descriptionLbl.topAnchor.constraint(equalTo: movieTitleLbl.bottomAnchor, constant: 5),
            descriptionLbl.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            descriptionLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            descriptionLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}


