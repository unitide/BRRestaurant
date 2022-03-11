//
//  RestaurantCollectionViewCell.swift
//  BRRestaurant
//
//  Created by Mingyong Zhu on 3/10/22.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let cellIdentifier = "RestaurantCell"
    
    @IBOutlet private weak var restaurantImage: UIImageView!
    @IBOutlet private weak var restaurantName: UILabel!
    @IBOutlet private weak var categoryName: UILabel!
    
    // MARK: - Functions
    
    func configureCell(restaurantName: String, categoryType: String, imageData: Data) {
        self.restaurantName.text = restaurantName
        self.categoryName.text = categoryType
        self.restaurantImage.image = UIImage(data: imageData)
    }
}
