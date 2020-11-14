//
//  AppsController.swift
//  AppStore
//
//  Created by Oleg Kudimov on 10/2/20.
//

import UIKit

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    
    fileprivate let cellId = "CellId"
    fileprivate let headerId = "HeaderId"
    
    
    var groups = [AppGroup]()
    var socialApps = [SocialApp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.backgroundColor = .white
        
        //cell register
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        
        //header register
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fetchData()
    }
    
    //loading indicator
    fileprivate let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    
    fileprivate func fetchData() {
        
        var group1: AppGroup?
        var group2: AppGroup?
        var group3: AppGroup?
        
        //synch our data fetching
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, error) in
            
            dispatchGroup.leave()
            group1 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, error) in
            
            dispatchGroup.leave()
            group2 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/10/explicit.json") { (appGroup, Err) in
            
            dispatchGroup.leave()
            group3 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps { (apps, error) in
            dispatchGroup.leave()
            self.socialApps = apps ?? []
        }
        //completion
        dispatchGroup.notify(queue: .main) {
            
            self.activityIndicatorView.stopAnimating()
            
            if let group = group1 {
                self.groups.append(group)
            }
            
            if let group = group2 {
                self.groups.append(group)
            }
            
            if let group = group3 {
                self.groups.append(group)
            }
            
            self.collectionView.reloadData()
        }
    }   

    
    //dequeue reusable header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
        
        header.appHeaderHorizontalController.socialApps = socialApps
        header.appHeaderHorizontalController.collectionView.reloadData()
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        
        let appGroup = groups[indexPath.item]
        
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalController.appGroup = appGroup
        cell.horizontalController.collectionView.reloadData()
        cell.horizontalController.didSelectHandler = { [weak self] feedResult in
            
            let detailController = AppDetailController(appId: feedResult.id)
            detailController.navigationItem.title = feedResult.name
            self?.navigationController?.pushViewController(detailController, animated: true)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
