//
//  iTunesSearchPresenter.swift
//  ProgrammaticUI
//
//  Created by Apple on 20/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import Foundation
import Moya

 //MARK: - iTunesSearchViewModel
class iTunesSearchViewModel {
    
    ///  This will interact with server and get search result and will pass on viewcontroller
    /// - Parameters:
    ///   - searchUser: what user name your write in search bar ,you have to pass here
    ///   - callBack: it will pass Result enum which contains item(users) array and moya error.
    /// - Returns: items(user) array will pass on ViewController
    class func getiTunesUsers(searchUser: String,callBack: @escaping(Swift.Result<[Result], MoyaError>) -> Void) -> Cancellable {
        APIManager.fetchResource(endpoint: .search(query: searchUser, page: 1)) { (result: Swift.Result<ITunes, MoyaError>) in
            let result = result.map { $0.results }
            callBack(result)
            print(result)
        }
    }
}

