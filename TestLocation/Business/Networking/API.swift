//
//  API.swift
//  TestLocation
//
//  Created by Taras Zinchenko on 24.10.2019.
//  Copyright © 2019 Taras Zinchenko. All rights reserved.
//

class API {
    static let shared = API()
    
    private init() {
        baseURL = "https://nominatim.openstreetmap.org/reverse.php"
    }
    
    let baseURL: String
    
    static let getAddress = ""
}
