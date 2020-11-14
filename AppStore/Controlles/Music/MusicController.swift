//
//  MusicController.swift
//  AppStore
//
//  Created by Oleg Kudimov on 11/12/20.
//

import UIKit

class MusicController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    
    fileprivate let cellId = "cellId"
    fileprivate let footerId = "footerId"
    fileprivate let searchTerm = "lenon"
    
    var results = [Result]()
    
    var isPaginating = false
    var isDonePaginating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.register(MusicCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(MusicLoadingFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerId)
        
        fetchData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    fileprivate func fetchData() {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=0&limit=20"
        
        Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, err) in
            
            if let err = err {
                print("Failed to paginate data: ", err)
                return
            }
            
            if searchResult?.results.count == 0 {
                self.isDonePaginating = true
            }
            
            self.results = searchResult?.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
        return footer
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        let height: CGFloat = isPaginating ? 0 : 100
        return .init(width: view.frame.width, height: height)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MusicCell
        //cell.backgroundColor = .red
        let track = results[indexPath.item]
        cell.nameLabel.text = track.trackName
        cell.imageView.sd_setImage(with: URL(string: track.artworkUrl100))
        cell.subtitleLabel.text = "\(track.artistName ?? "") • \(track.collectionName ?? "")"
         
        // Pagination
        if indexPath.item == results.count - 1 && !isPaginating{
            
            isPaginating = true
            let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&offset=\(results.count)&limit=20"
            
            Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: SearchResult?, err) in
                
                if let err = err {
                    print("Failed to paginate data: ", err)
                    return
                }
                
                sleep(2)
                
                self.results += searchResult?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
                self.isPaginating = false
                
            }
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 100)
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
//    }
}
