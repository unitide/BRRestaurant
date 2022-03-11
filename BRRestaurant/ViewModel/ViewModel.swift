//
//  ViewModel.swift
//  BRRestaurant
//
//  Created by Mingyong Zhu on 3/9/22.
//

import Foundation

class ViewModel {
    // MARK: - Properties
    
    private let networkManager: NetworkManager
    var restaurantChosen: Restaurant?
    @Published private(set) var restaurants = [Restaurant]()
    @Published private (set) var restaurantImages = [String: Data]()
    
    // MARK: - Initializers
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    // MARK: - Ineternal functions
    
    func fetchRestaurantData() {
        let url = NetworkURLs.restanrantJsonURL
        networkManager
            .getRestaurants(from: url) { [weak self] result in
                switch result {
                case .success(let results):
                    let response = results
                    self?.restaurants = response.restaurants
                    self?.fetchRestaurantImages()
                case .failure(let error):
                    // printing error in console
                    print(error)
                }
            }
    }
    
    func chosenRestaurant(row: Int) {
        let restaurant = restaurants[row]
        restaurantChosen = restaurant
    }
    
    // MARK: - Private functions
    
    private func fetchRestaurantImages() {
        let group = DispatchGroup()
        var temp = [String: Data]()
        for(restaurant) in self.restaurants {
            group.enter()
            networkManager.getImageData(from: restaurant.backgroundImageURL) { result in
                switch result {
                case .success( let data):
                    temp[restaurant.backgroundImageURL] = data
                case.failure(let error):
                    print(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.restaurantImages = temp
        }
    }
}
