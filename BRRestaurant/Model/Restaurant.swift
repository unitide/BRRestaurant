//
//  Restaurant.swift
//  BRRestaurant
//
//  Created by Mingyong Zhu on 3/11/22.
//

import Foundation

struct Restaurant: Codable {
    let name: String
    let backgroundImageURL: String
    let category: String
    let contact: Contact?
    let location: Location?
}
