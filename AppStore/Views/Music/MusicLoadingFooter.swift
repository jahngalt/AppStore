//
//  MusicLoadingFooter.swift
//  AppStore
//
//  Created by Oleg Kudimov on 11/12/20.
//

import UIKit


class MusicLoadingFooter: UICollectionReusableView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let aiv = UIActivityIndicatorView(style: .large)
        let label = UILabel(text: "Loading More...", font: .systemFont(ofSize: 16))
        label.textAlignment = .center
        
        
        aiv.color = .darkGray
        aiv.startAnimating()
        
        let stackView = VerticalStackView(arrangedSubviews: [aiv, label], spacing: 8)
        
        addSubview(stackView)
        stackView.centerInSuperview(size: .init(width: 200, height: 0))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
