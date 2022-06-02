//
//  APICaller.swift
//  Movie Box
//
//  Created by Александр Прайд on 31.05.2022.
//

import Foundation

enum APIError: Error {
    case FailedData
}

class APICaller {
    
    static let shared = APICaller()
    
    func getTrendingMovies(complition: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(K.basedURL)/3/trending/movie/day?api_key=\(K.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitle.self, from: data)
                complition(.success(results.results))
            } catch {
                complition(.failure(APIError.FailedData))
                
            }
        }
        task.resume()
    }
    
    func getTrendingTV(complition: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(K.basedURL)/3/trending/tv/day?api_key=\(K.apiKey)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitle.self, from: data)
                complition(.success(results.results))
            } catch {
                complition(.failure(APIError.FailedData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(complition: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string:  "\(K.basedURL)/3/movie/upcoming?api_key=\(K.apiKey)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitle.self, from: data)
                complition(.success(results.results))
            } catch {
                complition(.failure(APIError.FailedData))
            }
        }
        task.resume()
    }
    
    func getPopular(complition: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string:  "\(K.basedURL)/3/movie/popular?api_key=\(K.apiKey)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitle.self, from: data)
                complition(.success(results.results))
            } catch {
                complition(.failure(APIError.FailedData))
            }
        }
        task.resume()
    }
    
    func getTopRater(complition: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string:  "\(K.basedURL)/3/movie/top_rated?api_key=\(K.apiKey)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitle.self, from: data)
                complition(.success(results.results))
            } catch {
                complition(.failure(APIError.FailedData))
            }
        }
        task.resume()
    }

}
