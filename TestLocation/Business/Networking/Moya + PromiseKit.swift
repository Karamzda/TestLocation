//
//  Moya + PromiseKit.swift
//  TestLocation
//
//  Created by Taras Zinchenko on 24.10.2019.
//  Copyright © 2019 Taras Zinchenko. All rights reserved.
//

import PromiseKit
import Moya


public extension MoyaProvider {
    typealias PendingRequestPromise = (promise: Promise<Moya.Response>, cancellable: Cancellable)
    
    func requestCodable<T: Decodable>(target: Target,
                                             queue: DispatchQueue? = nil,
                                             progress: Moya.ProgressBlock? = nil) -> Promise<T> {
        let promise = requestPromise(target, queue: queue, progress: progress)
        let promisetResult = Promise<T>.init { resolver in
            promise.map{ response in
                let response = try response.filterSuccessfulStatusCodes()
                do {
                    let successResult = try response.map(T.self)
                    resolver.fulfill(successResult)
                } catch {
                    resolver.reject(BadResponseError(code: 666))
                }
            }
            .catch(resolver.reject)
        }
        return promisetResult
    }
    
    func requestPromise(_ target: Target,
                        queue: DispatchQueue? = nil,
                        progress: Moya.ProgressBlock? = nil) -> Promise<Moya.Response> {
        return requestCancellable(target: target, queue: queue, progress: progress).promise
    }
    
    private func requestCancellable(target: Target,
                                    queue: DispatchQueue?,
                                    progress: Moya.ProgressBlock? = nil) -> PendingRequestPromise {
        let pending = Promise<Moya.Response>.pending()
        let completion = promiseCompletion(resolver: pending.resolver)
        let cancellable: Cancellable = request(target, callbackQueue: queue, progress: progress, completion: completion)
        
        return (pending.promise, cancellable)
    }
    
    private func promiseCompletion(resolver: Resolver<Moya.Response>) -> Moya.Completion {
        return { result in
            switch result {
            case let .success(response):
                resolver.fulfill(response)
            case let .failure(error):
                resolver.reject(error)
            }
        }
    }
}
