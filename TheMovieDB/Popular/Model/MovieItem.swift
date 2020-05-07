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
struct Movie: Decodable {
    var id: Int
    var title, releaseDate: String
    var overview, posterPath: String
}

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.releaseDate == rhs.releaseDate && lhs.overview == rhs.overview && lhs.posterPath == rhs.posterPath
    }
}
