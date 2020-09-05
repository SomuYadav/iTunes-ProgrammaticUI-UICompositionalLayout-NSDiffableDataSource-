//
//  iTunessongDetailModel.swift
//  ProgrammaticUI
//
//  Created by Apple on 20/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import Foundation

typealias iTunesResult  = Result

/// it is representing a  Persist Container
struct PersistModel: Codable {
    ///it is representing song info
    var item: Result
    
    /// it is representing  to store data in  FileManager
    func save() {
        let doc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        do {
            try JSONEncoder().encode(self).write(to: doc[0].appendingPathComponent(self.item.artistName ?? ""))
        }catch {
            print(error)
        }
    }
    
    /// it is representing  to read data in from  FileManager
    /// - Returns: it will return a persit container which give decodable persit model
    static func read() -> [PersistModel] {
        let doc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return (try? FileManager.default.contentsOfDirectory(atPath: doc.path).compactMap {
            FileManager.default.contents(atPath: doc.appendingPathComponent($0).path)
        }
        .compactMap {
            try? JSONDecoder().decode(PersistModel.self, from: $0)
        }) ?? []
    }
    
    /// it is representing  to delete  data from from  FileManager
    func delete() {
        let doc = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let path = doc[0].appendingPathComponent(self.item.artistName ?? "")
        try? FileManager.default.removeItem(at: path)
    }
}
