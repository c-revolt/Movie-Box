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
        
        guard let url = URL(string: "\(K.basedURL)/3/trending/all/day?api_key=\(K.apiKey)") else { return }
        
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
}
