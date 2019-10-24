//
//  AddressResponseModel.swift
//  TestLocation
//
//  Created by Taras Zinchenko on 24.10.2019.
//  Copyright © 2019 Taras Zinchenko. All rights reserved.
//

struct AddressResponseModel: Codable {
    let placeID: Int?
    let licence, osmType: String?
    let osmID: Int?
    let lat, lon, displayName: String?
    let address: Address
    let boundingbox: [String]?
    
    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case licence
        case osmType = "osm_type"
        case osmID = "osm_id"
        case lat, lon
        case displayName = "display_name"
        case address, boundingbox
    }
}

// MARK: - Address
struct Address: Codable {
    let houseNumber, road, neighbourhood, suburb: String?
    let county, city, postcode, country: String?
    let countryCode: String?
    
    enum CodingKeys: String, CodingKey {
        case houseNumber = "house_number"
        case road, neighbourhood, suburb, county, city, postcode, country
        case countryCode = "country_code"
    }
}
