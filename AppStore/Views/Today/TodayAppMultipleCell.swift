//
//  TodayAppMultipleCell.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/28/20.
//

import UIKit


class TodayAppMultipleCell: BaseTodayCell {
    
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            
        }
    }
    
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 32), numberOfLines: 2)
    
    let multipleAppsController = UIViewController()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        multipleAppsController.view.backgroundColor = .red
        
        let stackView = VerticalStackView(arrangedSubviews: [
        categoryLabel,
        titleLabel,
        multipleAppsController.view], spacing: 12)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
