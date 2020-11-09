//
//  TodayItem.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/25/20.
//

import UIKit


struct TodayItem {
    
    let category: String
    let title: String
    let image: UIImage
    let desctiption: String
    let backgroundColor: UIColor
    
    //enum
    let cellType: CellType
    
    let apps: [FeedResults]
    
    
    enum CellType: String {
        case single, multiple
        
    }
    
     
}
