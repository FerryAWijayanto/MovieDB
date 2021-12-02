//
//  Network Data Fetcher.swift
//  MovieDB
//
//  Created by Ferry Adi Wijayanto on 30/11/21.
//

import Foundation


enum MDBError: String, Error {
    case unableToComplete       = "Unable to complete your request. Please check your internet connection"
    case invalidResponse        = "Invalid response from the server. Please try again"
    case invalidData            = "The data recieved from the server is invalid. Please try again"
}

protocol DataFetcher {
    func getDiscover(page: Int, completion: @escaping (Result<[MovieItem], MDBError>) -> Void)
    func getReviews(withID id: Int, completion: @escaping (Result<[ReviewItem], MDBError>) -> Void)
    func getVideos(withID id: Int, completion: @escaping (Result<[VideoItem], MDBError>) -> Void)
}

class NetworkDataFetcher: DataFetcher {
    private let service: Service
    
    init(service: Service) {
        self.service = service
    }
    
    func getDiscover(page: Int, completion: @escaping (Result<[MovieItem], MDBError>) -> Void) {
        service.request(endpoint: .discover(page: page)) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            if let decode = self.decode(jsonData: MovieResults.self, from: data) {
                completion(.success(decode.results))
            }
        }
    }
    
    func getReviews(withID id: Int, completion: @escaping (Result<[ReviewItem], MDBError>) -> Void) {
        service.request(endpoint: .reviews(id: id)) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            if let decode = self.decode(jsonData: ReviewResults.self, from: data) {
                completion(.success(decode.results))
            }
        }
    }
    
    func getVideos(withID id: Int, completion: @escaping (Result<[VideoItem], MDBError>) -> Void) {
        service.request(endpoint: .videos(id: id)) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            if let decode = self.decode(jsonData: VideoResults.self, from: data) {
                completion(.success(decode.results))
            }
        }
    }
    
}


extension NetworkDataFetcher {
    private func decode<T: Decodable>(jsonData type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = data else { return nil }
        
        do {
            let response = try decoder.decode(type, from: data)
            return response
        } catch {
            print(error)
            return nil
        }
    }
}
