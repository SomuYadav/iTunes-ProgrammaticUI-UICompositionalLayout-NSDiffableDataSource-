//
//  iTunesUser.swift
//  ProgrammaticUI
//
//  Created by Apple on 18/08/20.
//  Copyright © 2020 Somendra Yadav. All rights reserved.
//

import Foundation


// MARK: - ITunes
struct ITunes: Codable,Hashable {
    let resultCount: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable,Hashable {
    let wrapperType, kind: String?
    let artistID, collectionID, trackID: Int?
    let collectionName,collectionCensoredName: String?
    var artistName, trackName: String?
    let trackCensoredName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
    let collectionPrice: Double?
    let trackPrice: Double?
    let releaseDate: String
    let collectionExplicitness, trackExplicitness: String?
    let discCount: Int?
    let discNumber, trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country, currency, primaryGenreName: String?
    let isStreamable: Bool?
    
    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100,collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable
    }
}

