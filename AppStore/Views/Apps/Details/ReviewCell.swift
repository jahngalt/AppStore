//
//  ReviewCell.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/16/20.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 18))
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    
    let starsLabel = UILabel(text: "Stars", font: .systemFont(ofSize: 14))
    
    let starsStackView: UIStackView = {
        
        var arrangedViews = [UIView]()
        
        (0..<5).forEach { (_) in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedViews.append(imageView)
        }
        
        arrangedViews.append(UIView())
        let stackView = UIStackView(arrangedSubviews: arrangedViews)
        return stackView
    }()
    
    let bodyLabel = UILabel(text: "Review Body\nReview Body\nReview Body\n", font: .systemFont(ofSize: 16), numberOfLines:  5)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9447184205, green: 0.9427778125, blue: 0.9743997455, alpha: 1)
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [titleLabel,  authorLabel], customSpaing: 8),
            starsStackView,
            bodyLabel], spacing: 12)
        
        
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        authorLabel.textAlignment = .right
        
        addSubview(stackView)

        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
