//
//  AppFullScreenHeaderCell.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/23/20.
//

import UIKit

class AppFullScreenHeaderCell: UITableViewCell {
    
    
    
    let todayCell = TodayCell()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(todayCell)
        todayCell.fillSuperview()
        
//        contentView.addSubview(closeButton)
//        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 44, left: 0, bottom: 0, right: 12), size: .init(width: 80, height: 38))
        
        layer.cornerRadius = 16
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
