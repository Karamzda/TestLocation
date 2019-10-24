//
//  MapViewController.swift
//  TestLocation
//
//  Created by Taras Zinchenko on 24.10.2019.
//  Copyright © 2019 Taras Zinchenko. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MapViewProtocol {
    
    @IBOutlet weak var mapView: MKMapView!
    var presenter: MapPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
        setupMap()
    }
    
    func update(address: String) {
        self.navigationItem.title = address
    }
    
    func show(error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let actionSettigs = UIAlertAction(title: "Settings", style: .default) { [weak self] _ in
            self?.showSettings()
        }
        
        alertController.addAction(actionCancel)
        alertController.addAction(actionSettigs)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setupMap() {
        mapView.userTrackingMode = .followWithHeading
    }
    
    private func showSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }
    
    
}
