//
//  TodayCell.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/21/20.
//

import UIKit

class TodayCell: BaseTodayCell {
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 28))
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way", font: .systemFont(ofSize: 16), numberOfLines:  3)
    var topConstraint: NSLayoutConstraint!
    
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            imageView.image = todayItem.image
            descriptionLabel.text = todayItem.desctiption
            backgroundColor = todayItem.backgroundColor
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        clipsToBounds = true 
        imageView.contentMode = .scaleAspectFill
        
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 240, height: 240))
        let stackView = VerticalStackView(arrangedSubviews: [categoryLabel, titleLabel, imageContainerView, descriptionLabel], spacing: 8)
        addSubview(stackView)
        
        
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
        //stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        //stackView.fillSuperview()
        self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint.isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
