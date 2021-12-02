//
//  VideoResults.swift
//  MovieDB
//
//  Created by Ferry Adi Wijayanto on 30/11/21.
//

import Foundation

struct VideoResults: Codable {
    let results: [VideoItem]
}

// MARK: - Result
struct VideoItem: Codable {
    let key: String
    let publishedAt, site: String
    let size: Int
    let type: String
    let official: Bool
    let id: String
}
