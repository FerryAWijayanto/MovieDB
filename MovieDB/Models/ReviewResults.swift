//
//  ReviewResults.swift
//  MovieDB
//
//  Created by Ferry Adi Wijayanto on 30/11/21.
//

import Foundation

struct ReviewResults: Codable {
    let results: [ReviewItem]
}

// MARK: - Result
struct ReviewItem: Codable {
    let author: String
    let authorDetails: AuthorDetails?
    let content, createdAt, id, updatedAt: String
    let url: String
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    let name, username, avatarPath: String
    let rating: Int?
}
