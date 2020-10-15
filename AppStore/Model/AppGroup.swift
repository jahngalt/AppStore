//
//  AppGroup.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/5/20.
//

import Foundation


struct AppGroup: Decodable {
    
    
    let feed: Feed
}


struct Feed: Decodable {
    
    let title: String
    let results: [FeedResults]
}

struct FeedResults: Decodable {
    
    let id, name, artistName, artworkUrl100: String
    
}
