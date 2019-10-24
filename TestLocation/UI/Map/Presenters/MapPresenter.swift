//
//  MapPresenter.swift
//  TestLocation
//
//  Created by Taras Zinchenko on 24.10.2019.
//  Copyright © 2019 Taras Zinchenko. All rights reserved.
//

import Foundation

struct Location: Equatable {
    let latitude: Double
    let longitude: Double
}

class MapPresenter: MapPresenterProtocol {
    
    private var location: Location = Location(latitude: 0, longitude: 0)
    private var model: MapModel
    private var locationManager: LocationManager
    private unowned var view: MapViewProtocol
    
    required init(model: MapModel, view: MapViewProtocol, locationManager: LocationManager) {
        self.model = model
        self.view = view
        self.locationManager = locationManager
        
    }
    
    func viewLoaded() {
         checkAccess()
    }
    
    private func startUpdatingCoordinates() {
        
        model.onLocationUpdate = { [weak self] in
            let newLocation = Location(latitude: $0, longitude: $1)
            if self?.location != newLocation {
                self?.location = newLocation
                self?.getAddress()
            }
        }
        model.startGettingLocation()
    }
    
    private func getAddress(){
        model.getAddressFrom(latitude: location.latitude, longitude: location.longitude, completion: { [weak self] address in
            let address = "\(address.city ?? ""), \(address.road ?? ""), \(address.houseNumber ?? "")"
            self?.view.update(address: address)
        })
    }
    
    private func checkAccess() {
        let status = locationManager.authorizationStatus()
        switch status {
        case .denied, .restricted:
            self.view.show(error: "No access to GPS, please enable it in settings")
        case .authorizedAlways, .authorizedWhenInUse:
            startUpdatingCoordinates()
        case .notDetermined:
            locationManager.requestAutorisation()
        @unknown default:
            break
        }
        
        locationManager.onAuthorisationStatusChanged = { [weak self] status in
            self?.checkAccess()
        }
    }
    
}
