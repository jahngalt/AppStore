//
//  BaseListController.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/2/20.
//

import UIKit

class BaseListController: UICollectionViewController {

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
