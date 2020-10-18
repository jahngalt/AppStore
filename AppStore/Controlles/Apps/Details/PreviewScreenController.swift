//
//  PreviewScreenController.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/16/20.
//

import UIKit

class PreviewScreenController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "CellId"
    
    var app: Result? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        //collectionView.showsHorizontalScrollIndicator = false
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls.count ?? 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotCell
        
        let screenUrls = self.app?.screenshotUrls[indexPath.item]
        cell.imageView.sd_setImage(with: URL(string: screenUrls ?? ""))
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
}
