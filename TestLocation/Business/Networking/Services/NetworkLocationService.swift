//
//  LocationService.swift
//  TestLocation
//
//  Created by Taras Zinchenko on 24.10.2019.
//  Copyright © 2019 Taras Zinchenko. All rights reserved.
//

import PromiseKit
import Moya

class NetworkLocationService {
    static let shared = NetworkLocationService.init()
    private init() {}
    
    func getAddress(latitude: Double, longitude: Double) -> Promise<AddressResponseModel> {
        let parameters = ["format":"json", "lat": latitude, "lon": longitude] as [String : Any]
        return networkClient.requestCodable(target: NetworkClient.getAddress(parameters: parameters))
    }
}
