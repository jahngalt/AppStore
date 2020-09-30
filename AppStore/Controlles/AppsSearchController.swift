//
//  AppsSearchController.swift
//  AppStore
//
//  Created by Oleg Kudimov on 9/24/20.
//

import UIKit



class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK:- Properties
    fileprivate let cellId = "CellId"
    fileprivate var appResults = [Result]()
    
    //MARK:- Init
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        fetchITunesApp()
    }
    
    
    //number of cells in the screen
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appResults.count
    }
    
    
    //dequeuing our cell 
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        //if we're using CollectionView we should use indexPath.Item 
        let appResult = appResults[indexPath.item]
        
        cell.nameLabel.text = appResult.trackName
        cell.categoryLabel.text = appResult.primaryGenreName
        cell.ratingsLabel.text = "Rating: \(appResult.averageUserRating ?? 0)"
        return cell
    }
    
    
    //set the size of the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    

    fileprivate func fetchITunesApp() {
        Service.shared.fetchApps { (results, err) in
            
            if let err = err {
                print("Failed to fetch app: ", err)
                return
            }
            
            self.appResults = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
