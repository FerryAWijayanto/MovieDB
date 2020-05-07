//
//  MovieItem.swift
//  TheMovieDB
//
//  Created by Ferry Adi Wijayanto on 06/05/20.
//  Copyright © 2020 Ferry Adi Wijayanto. All rights reserved.
//

import Foundation

struct MovieItem: Decodable {
    var page, totalResults, totalPages: Int
    var results: [Movie]
}

// MARK: - Result
struct Movie: Codable {
    var id: Int
    var title, releaseDate: String
    var overview, posterPath: String
}

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.releaseDate == rhs.releaseDate && lhs.overview == rhs.overview && lhs.posterPath == rhs.posterPath
    }
}

//class Movie: NSObject, NSCoding, Decodable {
//    func encode(with coder: NSCoder) {
//        coder.encode(id, forKey: "movieIdKey")
//        coder.encode(title, forKey: "movieTitleKey")
//        coder.encode(releaseDate, forKey: "movieReleaseDateKey")
//        coder.encode(overview, forKey: "movieOverviewKey")
//        coder.encode(posterPath, forKey: "moviePosterPathKey")
//    }
//
//    required init?(coder: NSCoder) {
//        coder.decodeObject(forKey: "movieIdKey")
//        coder.decodeObject(forKey: "movieTitleKey")
//        coder.decodeObject(forKey: "movieReleaseDateKey")
//        coder.decodeObject(forKey: "movieOverviewKey")
//        coder.decodeObject(forKey: "moviePosterPathKey")
//    }
//
//    var id: Int?
//    var title, releaseDate: String?
//    var overview, posterPath: String?
//
//    init(id: Int, title: String, releaseDate: String, overview: String, posterPath: String) {
//        self.id = id
//        self.title = title
//        self.releaseDate = releaseDate
//        self.overview = overview
//        self.posterPath = posterPath
//    }
//}
