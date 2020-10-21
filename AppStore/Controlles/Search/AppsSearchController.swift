//
//  AppsSearchController.swift
//  AppStore
//
//  Created by Oleg Kudimov on 9/24/20.
//

import UIKit
//Pod for asyncronous image download and caching
import SDWebImage



class AppsSearchController: BaseListController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    //MARK:- Properties
    
    fileprivate let cellId = "CellId"
    fileprivate var appResults = [Result]()
    //adding search controller
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var timer: Timer?
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter the search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = String(appResults[indexPath.item].trackId)
        let appDetailController = AppDetailController(appId: appId)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 250, left: 50, bottom: 0, right: 50))
        
        setupSearchBar()
    }
    
    //MARK:- Methods
    //number of cells in the screen
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        enterSearchTermLabel.isHidden = appResults.count != 0
        return appResults.count
    }
    
    
    //dequeuing our cell 
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        //if we're using CollectionView we should use indexPath.Item 
        let appResult = appResults[indexPath.item]
        cell.appResult = appResult
        return cell
    }
    
    
    //set the size of the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    

//    fileprivate func fetchITunesApp() {
//        Service.shared.fetchApps(searchItem: "Facebook") { (results, err) in
//
//            if let err = err {
//                print("Failed to fetch app: ", err)
//                return
//            }
//
//            self.appResults = results
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
//    }
//
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    //MARK:- UISearchBarDelegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // here we need to implement some delay to correct displaying results
        // throttling the search
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            //all code located here will implementing with delay with 0,5 sec
            Service.shared.fetchApps(searchItem: searchText) { (res, err) in
                
                if let err = err {
                    print("there is some error in the searching process: ", err)
                    return
                }
                
                self.appResults = res?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
}
