//
//  Endpoint.swift
//  MovieDB
//
//  Created by Ferry Adi Wijayanto on 30/11/21.
//

import Foundation

enum Endpoint {
    case discover(page: Int)
    case reviews(id: Int)
    case videos(id: Int)
}

extension Endpoint {
    private var apiKey: String {
        return "api_key=a0a976df12b56f136a813ddfe5c0ecd7"
    }
    
    var url: URL {
        switch self {
        case .discover(let page): return .makeForEndpoint("3/discover/movie?\(apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(page)&with_watch_monetization_types=flatrate")
        case .reviews(let id):
            return .makeForEndpoint("3/movie/\(id)/reviews?\(apiKey)")
        case .videos(let id):
            return .makeForEndpoint("3/movie/\(id)/videos?\(apiKey)")
        }
    }
}
