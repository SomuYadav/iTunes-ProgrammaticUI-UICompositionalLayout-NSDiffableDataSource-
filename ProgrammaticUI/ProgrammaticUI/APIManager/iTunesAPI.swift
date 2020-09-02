//
//  iTunesAPI.swift
//  ProgrammaticUI
//
//  Created by Apple on 20/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import Foundation
import Moya

/// Edpoints and paramter info of all the API''s
enum iTunesAPI {
    case search(query: String, page: Int)
}

extension iTunesAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://itunes.apple.com")!
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search"
       }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .search(let query,_):
            return .requestParameters(parameters: [
                "term": query
            ], encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        switch self {
        case .search:
            return ["Content-Type": "application/json"]
        }
    }
}

