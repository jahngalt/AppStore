//
//  TodayMultipleAppsController.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/29/20.
//

import UIKit

class TodayMultipleAppsController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let cellId = "CellId"
    fileprivate let spacing: CGFloat = 16
    fileprivate var mode: Mode
    
    enum Mode {
        case small, fullscreen
    }

    var apps = [FeedResults]()
    
    //override var prefersStatusBarHidden: Bool { return true }
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if mode == .fullscreen {
            setupCloseButton()
            navigationController?.isNavigationBarHidden = true
        
            
        } else {
            collectionView.isScrollEnabled = false
        }
        //navigationController?.prefersStatusBarHidden = true
        collectionView.backgroundColor = .white
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true 
    }
    
    
    
    @objc  func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appId = self.apps[indexPath.item].id
        let appDetailController = AppDetailController(appId: appId)
    
        navigationController?.pushViewController(appDetailController, animated: true)
        
    }
    
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .fullscreen {
            return apps.count
        }
        
        return min(4, apps.count)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if mode == .fullscreen {
            return .init(top: 12, left: 24, bottom: 12, right: 24)
        }
        
        return .zero
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppCell
        cell.app = self.apps[indexPath.item]
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat = 68
        
        if mode == .fullscreen {
            return .init(width: view.frame.width - 48, height: height)
        }
        return .init(width: view.frame.width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}
