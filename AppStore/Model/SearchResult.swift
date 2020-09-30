//
//  SearchResult.swift
//  AppStore
//
//  Created by Oleg Kudimov on 9/28/20.
//

import Foundation


struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}


struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
}
