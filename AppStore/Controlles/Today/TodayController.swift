//
//  TodayController.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/21/20.
//

import UIKit

class TodayController: BaseListController, UICollectionViewDelegateFlowLayout {
    
//    fileprivate let cellId = "cellId"
//    fileprivate let multipleCellId = "multipleCellId"
    
    //cell size
    static let cellSize: CGFloat = 500
    
    var startingFrame: CGRect?
    var appFullScreenController: AppFullScreenController!
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    let items = [
        TodayItem.init(category: "The Daily List", title: "Test-drive These car play apps", image: #imageLiteral(resourceName: "garden"), desctiption: "", backgroundColor: .white, cellType: .multiple),
        TodayItem.init(category: "LIFE HACK", title: "Utilizing your time", image: #imageLiteral(resourceName: "garden"), desctiption: "All the tools and apps you need to intelligently organize your life the right way", backgroundColor: .white, cellType: .single),
        TodayItem.init(category: "LIFE HACK", title: "Utilizing your time", image: #imageLiteral(resourceName: "holiday"), desctiption: "All the tools and apps you need to intelligently organize your life the right way", backgroundColor: #colorLiteral(red: 0.9832287431, green: 0.9658947587, blue: 0.7224543095, alpha: 1), cellType: .single)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489067197, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayAppMultipleCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        collectionView.showsVerticalScrollIndicator = false
        
        
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cellId = items[indexPath.item].cellType.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: TodayController.cellSize)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let appFullScreenController = AppFullScreenController()
        appFullScreenController.todayItem = items[indexPath.row]
        appFullScreenController.dismissHandler = {
            self.handleRemoveRedView()
        }
        
        
        let fullScreenView = appFullScreenController.view!
        view.addSubview(fullScreenView)
        addChild(appFullScreenController)
        self.appFullScreenController = appFullScreenController
        
        self.collectionView.isUserInteractionEnabled = false
        
        guard let cell = collectionView.cellForItem(at: indexPath) else  { return }
        
        //absolute coordinates of cell
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
        
        //autolayout constraint animation
        //4 anchors
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()
        
        fullScreenView.layer.cornerRadius = 16
        

        //add animation
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.height
            
            guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else { return }
            
            cell.todayCell.topConstraint.constant = 48
            cell.layoutIfNeeded()
            
            
        }, completion: nil)
    }
    
    //remove view with animations when we click to the cell again
    @objc func handleRemoveRedView() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
   
            guard let startingFrame = self.startingFrame else { return }
            
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            self.view.layoutIfNeeded()
            self.appFullScreenController.tableView.contentOffset = .zero
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.height
            
            guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else { return }
            
            cell.todayCell.topConstraint.constant = 24
            cell.layoutIfNeeded()
            
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.height - tabBarFrame.height
            }
            
        }, completion: { _ in
            self.appFullScreenController.view.removeFromSuperview()
            //remove childController from parent
            self.appFullScreenController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
    
}
