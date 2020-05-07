//
//  PopularCell.swift
//  TheMovieDB
//
//  Created by Ferry Adi Wijayanto on 06/05/20.
//  Copyright © 2020 Ferry Adi Wijayanto. All rights reserved.
//

import UIKit

class PopularCell: UICollectionViewCell {

    static let cellID = "PopularCell"
    
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
        label.textColor = #colorLiteral(red: 0.9764705882, green: 0.8078431373, blue: 0.4274509804, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let likeBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "love-and-romance").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3568627451, green: 0.2745098039, blue: 0.1058823529, alpha: 1)
        [movieTitleLbl, likeBtn].forEach({ v in
            v.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(v)
        })
        
        NSLayoutConstraint.activate([
            movieTitleLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            movieTitleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieTitleLbl.widthAnchor.constraint(equalToConstant: 100),
            movieTitleLbl.heightAnchor.constraint(equalToConstant: 30),
            
            likeBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            likeBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            likeBtn.widthAnchor.constraint(equalToConstant: 16),
            likeBtn.heightAnchor.constraint(equalToConstant: 16)
        ])
        return view
    }()
    
    var btnSelected = false
    var movie: Movie?
    var userDefault = UserDefaults.standard
    private let key = "favoriteMovieKey"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        likeBtn.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        configure()
    }
    
    @objc private func handleFavorite() {
        if btnSelected == false {
            btnSelected = true
            likeBtn.setImage(#imageLiteral(resourceName: "love-and-romance-2"), for: .normal)
            likeBtn.tintColor = #colorLiteral(red: 0.9764705882, green: 0.8078431373, blue: 0.4274509804, alpha: 1)
            
            guard let movie = movie else { return }
            
            do {
                let encodeData: Data = try NSKeyedArchiver.archivedData(withRootObject: movie, requiringSecureCoding: true)
                userDefault.set(encodeData, forKey: key)
                userDefault.synchronize()
            } catch {
                print("Failed to archive data:", error)
            }
        } else {
            btnSelected = false
            likeBtn.setImage(#imageLiteral(resourceName: "love-and-romance").withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
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
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(movieImageView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(containerView, aboveSubview: movieImageView)
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

}
