//
//  SearchResultCell.swift
//  AppStore
//
//  Created by Oleg Kudimov on 9/25/20.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        return label
    }()
    
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photo & Video"
        return label
    }()
    
    
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.26M"
        return label
    }()
    
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16  
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelsStackView = UIStackView(arrangedSubviews: [
            nameLabel, categoryLabel, ratingsLabel
        ])
        
        labelsStackView.axis = .vertical
            
        let stackView = UIStackView(arrangedSubviews: [
            appIconImageView, labelsStackView, getButton
        ])
        
        backgroundColor = .yellow
        stackView.spacing = 12
        stackView.alignment = .center
        
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
