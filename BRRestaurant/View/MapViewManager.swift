//
//  MapViewManager.swift
//  BRRestaurant
//
//  Created by Mingyong Zhu on 3/10/22.
//

import CoreLocation
import MapKit

class MapViewManager {
    // MARK: - Propertes
    private let locationManager = CLLocationManager()
    
    // MARK: - Internal functions
    func setupMap(latitute: Double,longitude: Double,mapView: MKMapView,title: String?) {
        let lat = latitute
        let lng = longitude
        
        checkUserLocationAuthStatus(mapView: mapView)
        let initialLocation = CLLocation(latitude: lat, longitude: lng)
        mapView.centerToLocation(initialLocation)
        let restaurantAnnotatoion = MKPointAnnotation()
        restaurantAnnotatoion.title = title
        restaurantAnnotatoion.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        mapView.addAnnotation(restaurantAnnotatoion)
    }
    
    // MARK: - Private functions
    
    private func checkUserLocationAuthStatus(mapView: MKMapView) {
        switch locationManager.authorizationStatus {
        case .restricted, .denied:
            break
        case .notDetermined :
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        case .authorizedAlways:
            mapView.showsUserLocation = true
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
        @unknown default:
            break
        }
    }
    
}
// MARK: - Extensions

extension MKMapView {

  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1_000) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
