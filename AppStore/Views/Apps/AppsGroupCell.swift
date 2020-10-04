//
//  AppsGroupCell.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/2/20.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "App Section", font: .boldSystemFont(ofSize: 30))
    let horizontalController = AppsHorizonalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        addSubview(horizontalController.view)
        horizontalController.view.backgroundColor = .orange
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
