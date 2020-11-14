//
//  SearchResultCell.swift
//  AppStore
//
//  Created by Oleg Kudimov on 9/25/20.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    
    //MARK:- Properties
    
    
    var appResult: Result! {
        didSet {
            nameLabel.text = appResult.trackName
            categoryLabel.text = appResult.primaryGenreName
            
            ratingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
            
            
            let url = URL(string: appResult.artworkUrl100)
            appIconImageView.sd_setImage(with: url)
            screenshot1ImageView.sd_setImage(with: URL(string:appResult.screenshotUrls![0]))
            
            if appResult.screenshotUrls!.count > 1 {
                screenshot2ImageView.sd_setImage(with: URL(string:appResult.screenshotUrls![1]))
            }
            
            if appResult.screenshotUrls!.count > 2 {
                screenshot3ImageView.sd_setImage(with: URL(string:appResult.screenshotUrls![2]))
            }
        }
    }
    
    
    // Screenshot images
    lazy var screenshot1ImageView = createScreenshotImage()
    lazy var screenshot2ImageView = createScreenshotImage()
    lazy var screenshot3ImageView = createScreenshotImage()
    
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
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
    
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Labels stackView
        let labelsStackView = VerticalStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
        
        
        //Info top stack view
        let infoTopStackView = UIStackView(arrangedSubviews: [
            appIconImageView, labelsStackView, getButton
        ])
        backgroundColor = .white
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        addSubview(infoTopStackView)
        
        //Screenshots stackView
        let screenshotsStackView = UIStackView(arrangedSubviews: [screenshot1ImageView, screenshot2ImageView, screenshot3ImageView])
        screenshotsStackView.axis = .horizontal
        screenshotsStackView.spacing = 12
        screenshotsStackView.distribution = .fillEqually
        addSubview(screenshotsStackView)
        
        //Overall cell stackView
        let overallCellStackView = VerticalStackView(arrangedSubviews: [infoTopStackView, screenshotsStackView], spacing: 16)
        
        addSubview(overallCellStackView)
        overallCellStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    //MARK:- Methods
    func createScreenshotImage() -> UIImageView {
        let iv = UIImageView()
        
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        
        //iv.layer.borderWidth = 0.5
        //iv.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        return iv
    }
}
