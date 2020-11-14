//
//  MusicCell.swift
//  AppStore
//
//  Created by Oleg Kudimov on 11/12/20.
//

import UIKit

class MusicCell: UICollectionViewCell {
    
    
    let imageView = UIImageView(cornerRadius: 16)
    let nameLabel = UILabel(text: "Track name", font: .boldSystemFont(ofSize: 18))
    var subtitleLabel = UILabel(text: "Subtitle label", font: .systemFont(ofSize: 16), numberOfLines: 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.image = #imageLiteral(resourceName: "garden")
        imageView.constrainWidth(constant: 80)
        
        //backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedSubviews: [nameLabel, subtitleLabel], spacing: 4)], customSpaing: 16)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        stackView.alignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
