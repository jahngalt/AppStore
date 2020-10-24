//
//  AppFullScreenHeaderCell.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/23/20.
//

import UIKit

class AppFullScreenHeaderCell: UITableViewCell {
    
    
    
    let todayCell = TodayCell()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        addSubview(todayCell)
        
        todayCell.centerInSuperview(size: .init(width: 250, height: 250))
        //addSubview(closeButton)
        contentView.addSubview(closeButton)
        
        layer.cornerRadius = 16
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
       
        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 12), size: .init(width: 80, height: 38))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}