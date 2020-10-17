//
//  Reviews.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/16/20.
//

import Foundation


struct Reviews: Decodable {
    let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
    let entry: [Entry]
}

struct Entry: Decodable {
    let title: Label
    let content: Label
    let author: Author
}

struct Author: Decodable {
    let name: Label 
}

struct Label: Decodable {
    let label: String
}
