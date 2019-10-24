//
//  MapProtocols.swift
//  TestLocation
//
//  Created by Taras Zinchenko on 24.10.2019.
//  Copyright © 2019 Taras Zinchenko. All rights reserved.
//

protocol MapPresenterProtocol: class {
    init(model: MapModel, view: MapViewProtocol, locationManager: LocationManager)
    func viewLoaded()
}

protocol MapViewProtocol: class {
    var presenter: MapPresenter! { get set }
    func update(address: String)
    func show(error: String)
}

protocol MapModelProtocol: class {
    init(locationManager: LocationManager, networkService: NetworkLocationService) 
    func startGettingLocation()
    func getAddressFrom(latitude: Double, longitude: Double, completion: @escaping((Address) -> Void))
    func getDifference(currentLocation: (Double,Double), lastLocation: (Double,Double)) -> Double
}
