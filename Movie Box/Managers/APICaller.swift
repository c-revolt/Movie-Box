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
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(K.basedURL)/3/trending/movie/day?api_key=\(K.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitle.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.FailedData))
                
            }
        }
        task.resume()
    }
    
    func getTrendingTV(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(K.basedURL)/3/trending/tv/day?api_key=\(K.apiKey)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitle.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.FailedData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string:  "\(K.basedURL)/3/movie/upcoming?api_key=\(K.apiKey)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitle.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.FailedData))
            }
        }
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string:  "\(K.basedURL)/3/movie/popular?api_key=\(K.apiKey)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitle.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.FailedData))
            }
        }
        task.resume()
    }
    
    func getTopRater(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string:  "\(K.basedURL)/3/movie/top_rated?api_key=\(K.apiKey)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitle.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.FailedData))
            }
        }
        task.resume()
    }
    
    func getSearchMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        

        guard let url = URL(string:  "\(K.basedURL)/3/discover/movie?api_key=\(K.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitle.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.FailedData))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(K.basedURL)/3/search/movie?api_key=\(K.apiKey)&query=\(query)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitle.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.FailedData))
            }
        }
        task.resume()
    }
    
    
    func getMoview(with query: String, completion: @escaping (Result<YTVideo, Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(K.youtubeBasedURL)q=\(query)&key=\(K.apiKeyYouTube)") else { return }
        
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(YouTubeSearch.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

}
