//
//  MapSceneConfigurator.swift
//  TestLocation
//
//  Created by Taras Zinchenko on 24.10.2019.
//  Copyright © 2019 Taras Zinchenko. All rights reserved.
//

import UIKit

class MapSceneConfigurator {
    func configure(_ accuracy: Double) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let locationManager = LocationManager.shared
        locationManager.desiredAccuracy = 50
        let viewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        let model = MapModel(locationManager: locationManager, networkService: NetworkLocationService.shared)
        let presenter = MapPresenter(model: model, view: viewController, locationManager: locationManager)
        viewController.presenter = presenter
        
        return viewController
    }
}
