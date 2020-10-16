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
    let screenshotUrls: [String] 
    //App icon
    let artworkUrl100: String
    let artworkUrl512: String 
    let formattedPrice: String
    let description: String
    let releaseNotes: String 
}
