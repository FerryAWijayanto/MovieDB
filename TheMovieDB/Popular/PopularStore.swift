//
//  PopularStore.swift
//  TheMovieDB
//
//  Created by Ferry Adi Wijayanto on 06/05/20.
//  Copyright © 2020 Ferry Adi Wijayanto. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum MovieError: String, Error {
    case invalidURL = "Can't get movie url"
    case invalidResponse = "Network error"
    case invalidData = "Failed to fetch data"
    case failedToParseJSON = "failed to parse JSON"
}

enum ImageError: Error {
    case imageCreationError
}

class PopularStore {
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Movie")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error to setup core data \(error)")
            }
        }
        return container
    }()
    
    private let imageURLString = "https://image.tmdb.org/t/p/w500"

    func paginateMovie(in view: UIScrollView, completion: @escaping () -> Void) {
        let offsetY = view.contentOffset.y
        let contentHeight = view.contentSize.height
        let height = view.frame.height
        
        if offsetY > contentHeight - height {
            completion()
        }
    }
    
    func fetchMovie(page: Int, completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        let url = MovieDBAPI.movieDBURL(parameters: ["language": "en-US", "page": "\(page)"])
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            let result = self.processMovieRequest(data: data, error: error)
            
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    func fetchImage(for movie: Movie, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let movieURL = URL(string: "\(imageURLString)\(movie.posterPath)") else { return }
        let request = URLRequest(url: movieURL)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let result = self.processImageData(data: data, error: error)
            
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processMovieRequest(data: Data?, error: Error?) -> Result<[Movie], MovieError> {
        guard let jsonData = data else {
            return .failure(.invalidData)
        }
        return MovieDBAPI.movies(fromJSON: jsonData)
    }
    
    private func processImageData(data: Data?, error: Error?) -> (Result<UIImage, Error>) {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(ImageError.imageCreationError)
                }
        }
        return .success(image)
    }
}

