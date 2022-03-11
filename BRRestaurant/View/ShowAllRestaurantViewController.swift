//
//  ShowAllRestaurantViewController.swift
//  BRRestaurant
//
//  Created by Mingyong Zhu on 3/10/22.
//
import MapKit
import UIKit

class ShowAllRestaurantViewController: UIViewController {
    // MARK: - Properties
    var viewModel: ViewModel?
    private let mapViewManager = MapViewManager()
    var myMapView = MKMapView()
    private lazy var myToolBar: UIToolbar = {
         let toolBar = UIToolbar()
         var items = [UIBarButtonItem]()
        
         items.append(UIBarButtonItem.flexibleSpace())
        items.append(UIBarButtonItem(image: UIImage(named: "icClose"), style: .done, target: self, action: #selector(dismissMapView)))
         toolBar.setItems(items, animated: true)
         return toolBar
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addRestraurantsToMap()
    }
    
    // MARK: - Functions
    
    private func setupUI() {
        
        self.view.addSubview(myMapView)
        self.view.addSubview(myToolBar)
        
        myToolBar.translatesAutoresizingMaskIntoConstraints = false
        
        let safeGuide = self.view.safeAreaLayoutGuide
        myToolBar.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
        myToolBar.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -5).isActive = true
        let deviceType = UIDevice().model
        
        if deviceType.contains("iPad") {
            myToolBar.heightAnchor.constraint(equalToConstant: 80).isActive = true
            myToolBar.widthAnchor.constraint(equalToConstant: 80).isActive = true
            
        } else {
            myToolBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
            myToolBar.widthAnchor.constraint(equalToConstant: 50).isActive = true
        }
        myMapView.frame = self.view.bounds
    }
    
    private func addRestraurantsToMap() {
         if let allRestrants = viewModel?.restaurants {
             for restaurant in allRestrants {
                 let lat = restaurant.location?.lat ?? 40.712_8
                 let lng = restaurant.location?.lng ?? -74.006_0
                 let restaurantName = viewModel?.restaurantChosen?.name
                 mapViewManager.setupMap(latitute: lat, longitude: lng, mapView: myMapView, title: restaurantName)
             }
        }
    }
    
    @objc
    private func dismissMapView () {
        self.dismiss(animated: true)
    }
}
