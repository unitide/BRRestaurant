//
//  DetailRestaurantViewController.swift
//  BRRestaurant
//
//  Created by Mingyong Zhu on 3/10/22.
//

import MapKit
import UIKit

class DetailRestaurantViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var restaurantName: UILabel!
    @IBOutlet private weak var categoryType: UILabel!
    @IBOutlet private weak var address1: UILabel!
    @IBOutlet private weak var address2: UILabel!
    @IBOutlet private weak var formattedPhone: UILabel!
    @IBOutlet private weak var twitter: UILabel!
    
    // MARK: - Properties
    
    var viewModel: ViewModel?
    private var mapViewManager = MapViewManager()

    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
       
        let lat = viewModel?.restaurantChosen?.location?.lat ?? 40.712_8
        let lng = viewModel?.restaurantChosen?.location?.lng ?? -74.006_0
        let restaurantName = viewModel?.restaurantChosen?.name
        mapViewManager.setupMap(latitute: lat, longitude: lng, mapView: mapView, title: restaurantName)
    }
    
    // MARK: - Private functions
    
    private func setupUI() {
        restaurantName.text = viewModel?.restaurantChosen?.name
        categoryType.text = viewModel?.restaurantChosen?.category
        address1.text = viewModel?.restaurantChosen?.location?.formattedAddress[0]
        address2.text = viewModel?.restaurantChosen?.location?.formattedAddress[1]
        formattedPhone.text = viewModel?.restaurantChosen?.contact?.formattedPhone
        twitter.text = viewModel?.restaurantChosen?.contact?.twitter
    }
  
    @IBAction private func showRestaurants(_ sender: UIBarButtonItem) {
        let showRestaurantVC = ShowAllRestaurantViewController()
        showRestaurantVC.viewModel = self.viewModel
        showRestaurantVC.modalPresentationStyle = .fullScreen
        self.present(showRestaurantVC, animated: true)
    }
}
