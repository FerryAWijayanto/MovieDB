//
//  MovieDBAPI.swift
//  TheMovieDB
//
//  Created by Ferry Adi Wijayanto on 06/05/20.
//  Copyright © 2020 Ferry Adi Wijayanto. All rights reserved.
//

import Foundation

struct MovieDBAPI {
    static var topRated: URL {
        return movieDBURL(parameters: ["language": "en-US", "page": "1"])
    }
    
    private static let baseURLString = "https://api.themoviedb.org/3/movie/top_rated"
    
    private static let key = "a0a976df12b56f136a813ddfe5c0ecd7"
    
    static func movieDBURL(parameters: [String: String]?) -> URL {
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "api_key": key
        ]
        
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParameter = parameters {
            for (key, value) in additionalParameter {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        
        return components.url!
    }
    
    static func movies(fromJSON data: Data) -> Result<[Movie], MovieError> {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let jsonData = try decoder.decode(MovieItem.self, from: data)
            var items = [Movie]()
            
            print(jsonData)
            for movie in jsonData.results {
                if let movie = createMovie(fromJSON: movie) {
                    items.append(movie)
                }
            }
            
            return .success(items)
        } catch {
            return .failure(.failedToParseJSON)
        }
    }
    
    private static func createMovie(fromJSON movie: Movie) -> Movie? {
        let id = movie.id ?? 0
        let title = movie.title ?? ""
        let releaseDate = movie.releaseDate ?? ""
        let overview = movie.overview ?? ""
        let posterPath = movie.posterPath ?? ""
        
        
        return Movie(id: id, title: title, releaseDate: releaseDate, overview: overview, posterPath: posterPath)
    }
}
