//
//  Location.swift
//  BRRestaurant
//
//  Created by Mingyong Zhu on 3/9/22.
//

import UIKit

struct Location: Codable {
    let address: String
    let crossStreet: String?
    let lat: Double
    let lng: Double
    let postalCode: String?
    let cc: String
    let city: String
    let state: String
    let country: String
    let formattedAddress: [String]
}
