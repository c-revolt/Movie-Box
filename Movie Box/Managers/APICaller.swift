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
    
    func gettrandingMovies(complition: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let url = URL(string: "\(K.basedURL)/3/trending/movie/day?api_key=\(K.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrandingMovies.self, from: data)
                complition(.success(results.results))
            } catch {
                complition(.failure(error))
                
            }
        }
        task.resume()
    }
    
    func getTrandingTV(complition: @escaping (Result<[Tv], Error>) -> Void) {
        guard let url = URL(string: "\(K.basedURL)/3/trending/tv/day?api_key=\(K.apiKey)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrandingTVResponse.self, from: data)
                print(results)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getUpComingMovie(complition: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string:  "\(K.basedURL)/3/movie/upcoming?api_key=\(K.apiKey)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrandingMovies.self, from: data)
                print(results)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getPopular(complition: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string:  "\(K.basedURL)/3/movie/popular?api_key=\(K.apiKey)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrandingMovies.self, from: data)
                print(results)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getTopRater(complition: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string:  "\(K.basedURL)/3/movie/top_rated?api_key=\(K.apiKey)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrandingMovies.self, from: data)
                print(results)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }

}
