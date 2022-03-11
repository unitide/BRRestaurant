//
//  LunchViewController.swift
//  BRRestaurant
//
//  Created by Mingyong Zhu on 3/10/22.
//

import Combine
import UIKit
import MapKit

class LunchViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet private weak var restaurantCollectionView: UICollectionView!
    
    private let viewModel = ViewModel()
    private var subscribers = Set<AnyCancellable>()
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBinding()
        setUpCollectionView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? DetailRestaurantViewController
        destination?.viewModel = viewModel
    }
 
    // MARK: - Private functions
    
    private func setUpBinding() {
        viewModel
            .$restaurantImages
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.restaurantCollectionView?.reloadData()
            }
            .store(in: &subscribers)
        
        viewModel.fetchRestaurantData()
    }
    
    private func setUpCollectionView() {
        restaurantCollectionView?.dataSource = self
        restaurantCollectionView?.delegate = self
        restaurantCollectionView?.reloadData()
        var itemWidth: Double
        
        // Setup collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let deviceType = UIDevice().model
        if deviceType.contains("iPad") {
            itemWidth = floor(UIScreen.main.bounds.width / 4)
        } else {
            itemWidth = UIScreen.main.bounds.width
        }
        let size = CGSize(width: itemWidth, height: 180)
        
        layout.itemSize = size
        layout.minimumLineSpacing = 5
        restaurantCollectionView?.collectionViewLayout = layout
    }
    
    @IBAction private func showRestrants(_ sender: UIBarButtonItem) {
        let showRestaurantVC = ShowAllRestaurantViewController()
        showRestaurantVC.viewModel = self.viewModel
        showRestaurantVC.modalPresentationStyle = .fullScreen
        self.present(showRestaurantVC, animated: true)
    }
}

// MARK: - Extensions

extension LunchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantCell", for: indexPath) as? RestaurantCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let row = indexPath.row
        let restaurant = viewModel.restaurants[row]
        if let restaurantImage = viewModel.restaurantImages[restaurant.backgroundImageURL] {
            cell.configureCell(restaurantName: restaurant.name, categoryType: restaurant.category, imageData: restaurantImage )
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension LunchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.chosenRestaurant(row: indexPath.row)
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
}
