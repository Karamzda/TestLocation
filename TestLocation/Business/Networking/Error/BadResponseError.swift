//
//  BadResponseError.swift
//  TestLocation
//
//  Created by Taras Zinchenko on 24.10.2019.
//  Copyright © 2019 Taras Zinchenko. All rights reserved.
//
class BadResponseError: Error {
    typealias ErrorCode = Int
    
    let code: ErrorCode
    
    init(code: ErrorCode) {
        self.code = code
    }
}
