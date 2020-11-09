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
    var items = [TodayItem]()
    var anchoredConstraints: AnchoredConstraints?
    
    let activityIndicator: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
        
        fetchData()
        
        navigationController?.isNavigationBarHidden = true
        collectionView.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489067197, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayAppMultipleCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        collectionView.showsVerticalScrollIndicator = false
    }
    
    
    fileprivate func fetchData() {
        // executing dispatch group
        
        let dispatchGroup = DispatchGroup()
        var topGrossingGroup: AppGroup?
        var gamesGroup: AppGroup?
        
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (app, error) in
            
            // error check
            topGrossingGroup = app
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (app, error) in
            gamesGroup = app
            dispatchGroup.leave()
        }
        
        // completion block
        dispatchGroup.notify(queue: .main) {
            
            self.activityIndicator.stopAnimating()
            self.items = [
                
                TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), desctiption: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single, apps: []),
                
                
                TodayItem.init(category: "Daily List", title: topGrossingGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), desctiption: "", backgroundColor: .white, cellType: .multiple, apps: topGrossingGroup?.feed.results ?? []),
                
                TodayItem.init(category: "Daily List", title: gamesGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), desctiption: "", backgroundColor: .white, cellType: .multiple, apps: gamesGroup?.feed.results ?? []),
                
                
                TodayItem.init(category: "HOLIDAYS", title: "Travel on a budget", image: #imageLiteral(resourceName: "holiday"), desctiption: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9825407863, green: 0.9558627009, blue: 0.7308741212, alpha: 1), cellType: .single, apps: [])
            ]
            self.collectionView.reloadData()
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cellId = items[indexPath.item].cellType.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.item]
        
        (cell as? TodayAppMultipleCell)?.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))
        return cell
    }
    
    
    @objc fileprivate func handleMultipleAppsTap(gesture: UIGestureRecognizer) {
        
        let collectionView = gesture.view
        var superview = collectionView?.superview
        while superview != nil {
            
            if let cell = superview as?  TodayAppMultipleCell {
                
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                
                let apps = self.items[indexPath.item].apps
                
                let fullController = TodayMultipleAppsController(mode: .fullscreen)
                fullController.apps = apps
                
                let controller = BackEnabledNavigationController(rootViewController: fullController)
                controller.modalPresentationStyle = .fullScreen
                present(controller, animated: true, completion: nil)
                return
            }
            superview = superview?.superview
        }
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
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
    
    
    fileprivate func showDailyListFullScreen(_ indexPath: IndexPath) {
        let fullController = TodayMultipleAppsController(mode: .fullscreen)
        //fullController.prefersStatusBarHidden = true
        let controllerToPresent = BackEnabledNavigationController (rootViewController: fullController)
        controllerToPresent.modalPresentationStyle = .fullScreen
        //controllerToPresent.navigationBar.prefersLargeTitles = false
        fullController.apps = self.items[indexPath.item].apps
        present(controllerToPresent, animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch items[indexPath.item].cellType {
        case .multiple:
            showDailyListFullScreen(indexPath)
        case .single:
        showSingleAppFullscreen(indexPath: indexPath)
        }
    }
    
    
    fileprivate func setupSingleAppFullScreenController(_ indexPath: IndexPath) {
        let appFullScreenController = AppFullScreenController()
        appFullScreenController.todayItem = items[indexPath.row]
        appFullScreenController.dismissHandler = {
            self.handleRemoveRedView()
        }
        
        appFullScreenController.view.layer.cornerRadius = 16
        self.appFullScreenController = appFullScreenController
    }
    
    
    fileprivate func setupStartingCellFrame(_ indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) else  { return }
        //absolute coordinates of cell
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
    }
    
    
    fileprivate func setupAppFullScreenStartupPosition(_ indexPath: IndexPath) {
        let fullScreenView = appFullScreenController.view!
        view.addSubview(fullScreenView)
        addChild(appFullScreenController)
        
        self.collectionView.isUserInteractionEnabled = false
        
        
        setupStartingCellFrame(indexPath)
        
        guard let startingFrame = self.startingFrame else { return }
        //autolayout constraint animation
        //4 anchors
        
        self.anchoredConstraints = fullScreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
        
        self.view.layoutIfNeeded()
    }
    
    
    fileprivate func beginAnimationAppFullScreen() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.anchoredConstraints?.top?.constant = 0
            self.anchoredConstraints?.leading?.constant = 0
            self.anchoredConstraints?.width?.constant  = self.view.frame.width
            self.anchoredConstraints?.height?.constant = self.view.frame.height
            

            
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.height
            
            guard let cell = self.appFullScreenController.tableView.cellForRow(at: [0, 0]) as? AppFullScreenHeaderCell else { return }
            
            cell.todayCell.topConstraint.constant = 48
            cell.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    
    fileprivate func showSingleAppFullscreen(indexPath: IndexPath) {
        
        // Setting up the fullScreen controller
        setupSingleAppFullScreenController(indexPath)
        
        // Setup fullscreen in its starting position
        setupAppFullScreenStartupPosition(indexPath)
        
        // Enabling animation
        beginAnimationAppFullScreen()
    }
    
    //remove view with animations when we click to the cell again
    @objc func handleRemoveRedView() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
   
            guard let startingFrame = self.startingFrame else { return }
            
            self.anchoredConstraints?.top?.constant = startingFrame.origin.y
            self.anchoredConstraints?.leading?.constant = startingFrame.origin.x
            self.anchoredConstraints?.width?.constant = startingFrame.width
            self.anchoredConstraints?.height?.constant = startingFrame.height
            
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
