//
//  APIManager.swift
//  ProgrammaticUI
//
//  Created by Apple on 21/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import Foundation
import Moya

/// APIManager will all network request in our app
class APIManager {
    
    /// MoyaProvider is an generic class where it take Target Type as it's generric parameter so that i have all the neccessary things to genrate APi requests
    static let provider = MoyaProvider<iTunesAPI>(plugins: [NetworkLoggerPlugin()])
    
    /// FetchResource  is generic method which takes decodable as parameter and the endpoint to hit then call the completion with an result of that decodable type or moya error
    ///   - endpoint: case if  iTunes Api have to hit
    ///   - onComplete: this closure get called with result once the request completes
    /// - Returns: returns an cancellable token to cancel the request on demand
    @discardableResult
    static func fetchResource<T: Decodable>(endpoint: iTunesAPI, onComplete: @escaping (Swift.Result<T,MoyaError>)->Void) -> Cancellable {
        return provider.request(endpoint) { result in
            switch result {
            case .success(let response):
                do {
                    // Checking for succes code
                    let successResponse = try response.filterSuccessfulStatusCodes()
                    // Decoding to object
                    let decoded = try successResponse.map(T.self)
                    onComplete(.success(decoded))
                } catch {
                    let moyaError = (error as? MoyaError) ?? MoyaError.objectMapping(error, response)
                    onComplete(.failure(moyaError))
                }
            case .failure(let error):
                onComplete(.failure(error))
            }
        }
    }
}
