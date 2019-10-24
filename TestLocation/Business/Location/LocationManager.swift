//
//  LocationManager.swift
//  TestLocation
//
//  Created by Taras Zinchenko on 24.10.2019.
//  Copyright © 2019 Taras Zinchenko. All rights reserved.
//

import CoreLocation

protocol LocationManagerDelegate: class {
    func updateLocation(latitude: Double, longitude: Double)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager: CLLocationManager!
    weak var delegate: LocationManagerDelegate?
    var onAuthorisationStatusChanged: ((_ status: CLAuthorizationStatus) -> Void)?
    
    static let shared = LocationManager()
    
    var desiredAccuracy: Double = 100 { didSet {
        locationManager.desiredAccuracy = desiredAccuracy
        }}
    
    private override init() {
        self.locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
    }
    
    func startUpdating() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            return true
        }
        return false
    }
    
    func requestAutorisation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        delegate?.updateLocation(latitude: locValue.latitude, longitude: locValue.longitude)
    }
    
    func getDifference(currentLocation: (lat: Double, lon: Double), lastLocation: (lat: Double,lon: Double)) -> Double {
        return CLLocation(latitude: currentLocation.lat, longitude: currentLocation.lon)
            .distance(from: CLLocation(latitude: lastLocation.lat, longitude: lastLocation.lon))
    }
    
    func authorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        onAuthorisationStatusChanged?(status)
    }
    
}
