//
//  ScreenshotCell.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/16/20.
//

import UIKit



class ScreenshotCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.backgroundColor = .purple
        
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.fillSuperview()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
