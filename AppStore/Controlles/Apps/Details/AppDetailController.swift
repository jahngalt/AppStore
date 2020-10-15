//
//  AppDetailController.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/15/20.
//

import UIKit

class AppDetailController: BaseListController {
    
    var appId: String! {
        didSet {
            print("HEre is my appId, ", appId)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .yellow
        
    }
    
    
}
