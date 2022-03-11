//
//  NetworkManager.swift
//  BRRestaurant
//
//  Created by Mingyong Zhu on 3/9/22.
//

import Foundation

class NetworkManager {
    
    // MARK: - Functions
    
    func getRestaurants(from url: String, completion: @escaping (Result<RestaurantResponse, NetworkError>) -> Void ) {
        guard let url = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in

            if let error = error {
                completion(.failure(.other(error)))
                return
            }

            if let data = data {
                // decode
                do {
                    let response = try JSONDecoder().decode(RestaurantResponse.self, from: data)
                    completion(.success(response))
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let error {
                    print(error)
                    completion(.failure(.other(error)))
                }
            }
        }
        .resume()
    }
    
    func getImageData(from url: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                completion(.success(data))
            }
            
            if let error = error {
                completion(.failure(.other(error)))
            }
        }
        .resume()
    }
}
