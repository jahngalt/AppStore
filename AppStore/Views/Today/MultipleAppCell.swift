//
//  MultipleAppCell.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/29/20.
//

import UIKit

class MultipleAppCell: UICollectionViewCell {
    
    var app: FeedResults! {
        didSet {
            nameLabel.text = app.name
            companyLabel.text = app.artistName
            
            imageView.sd_setImage(with: URL(string: app.artworkUrl100))
        }
    }
    
    
    let imageView = UIImageView(cornerRadius: 8)
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 16))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    let getButton = UIButton(title: "GET")
    let nameLabelSize: CGFloat = 16
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        imageView.backgroundColor = .purple
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        
        getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        getButton.constrainHeight(constant: 32)
        getButton.constrainWidth(constant: 80)
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: nameLabelSize)
        getButton.layer.cornerRadius = 32 / 2
        
        let stackView =  UIStackView(arrangedSubviews: [
                                        imageView,
                                        VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4),
                                        getButton])
        stackView.spacing = 16
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview()
        //adding live separator between cells
        addSubview(separatorView)
        separatorView.anchor(top: nil, leading: nameLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -6, right: 0), size: .init(width: 0, height: 0.2))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
