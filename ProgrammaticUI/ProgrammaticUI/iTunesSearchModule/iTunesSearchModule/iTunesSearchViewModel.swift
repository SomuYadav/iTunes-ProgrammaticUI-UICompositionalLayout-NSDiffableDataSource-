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
    ///   - search Song: what song name your write in search bar ,you have to pass here
    ///   - callBack: it will pass Result enum which contains item(songs) array and moya error.
    /// - Returns: items(songs) array will pass on ViewController
    class func getiTunessongs(searchsong: String,callBack: @escaping(Swift.Result<[Result], MoyaError>) -> Void) -> Cancellable {
        APIManager.fetchResource(endpoint: .search(query: searchsong, page: 1)) { (result: Swift.Result<ITunes, MoyaError>) in
            let result = result.map { $0.results }
            callBack(result)
            print(result)
        }
    }
}

