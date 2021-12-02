//
//  MovieResults.swift
//  MovieDB
//
//  Created by Ferry Adi Wijayanto on 30/11/21.
//

import Foundation

struct MovieResults: Codable {
    var page: Int
    var results: [MovieItem]
}

struct MovieItem: Codable {
    let id: Int
    let posterPath: String
    let overview: String
    let releaseDate: String
    let title: String
}

extension MovieItem: Equatable, Hashable {
    static func == (lhs: MovieItem, rhs: MovieItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
