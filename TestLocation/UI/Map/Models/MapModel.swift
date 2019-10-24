//
//  MapModel.swift
//  TestLocation
//
//  Created by Taras Zinchenko on 24.10.2019.
//  Copyright © 2019 Taras Zinchenko. All rights reserved.
//

import Foundation
import PromiseKit
import Moya



class MapModel: MapModelProtocol {
    
    private let networkService: NetworkLocationService
    private let locationManager: LocationManager
    var onLocationUpdate: ((_ latitude: Double, _ longitude: Double) -> Void)?
    
    
    required init(locationManager: LocationManager, networkService: NetworkLocationService) {
        self.networkService = networkService
        self.locationManager = locationManager
    }
    
    func startGettingLocation() {
        locationManager.delegate = self
        _ = locationManager.startUpdating()
        
    }
    
    func getAddressFrom(latitude: Double, longitude: Double,  completion: @escaping((Address) -> Void)) {
        _ = networkService.getAddress(latitude: latitude, longitude: longitude).done { result in
            completion(result.address)
        }
    }
    
    func getDifference(currentLocation: (Double, Double), lastLocation: (Double, Double)) -> Double {
        return locationManager.getDifference(currentLocation: currentLocation, lastLocation: lastLocation)
    }
}


extension MapModel: LocationManagerDelegate {
    func updateLocation(latitude: Double, longitude: Double) {
        onLocationUpdate?(latitude, longitude)
    }
    
}
