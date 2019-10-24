//
//  NetworkClient.swift
//  TestLocation
//
//  Created by Taras Zinchenko on 24.10.2019.
//  Copyright © 2019 Taras Zinchenko. All rights reserved.
//

import Moya


var networkClient = MoyaProvider<NetworkClient>(plugins: [NetworkLoggerPlugin(verbose: true)])


enum NetworkClient {
    case getAddress(parameters: [String: Any])
}

extension NetworkClient: TargetType {
    var baseURL: URL {
        return URL(string: API.shared.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getAddress: return API.getAddress
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return .init()
    }
    
    var task: Task {
        switch self {
        case .getAddress(let parameters): return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        let basicHeaders:[String:String] = ["Content-Type": "application/json"]
        return basicHeaders
    }
    
    
}
