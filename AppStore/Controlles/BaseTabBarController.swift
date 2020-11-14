//
//  BaseTabBarController.swift
//  AppStore
//
//  Created by Oleg Kudimov on 9/24/20.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewControllers = [
            createNavController(viewController: MusicController(), title: "Music", imageName: #imageLiteral(resourceName: "music")),
            createNavController(viewController: TodayController(), title: "Today", imageName: #imageLiteral(resourceName: "today_icon")),
            createNavController(viewController: AppsPageController(), title: "Apps", imageName: #imageLiteral(resourceName: "apps")),
            createNavController(viewController: AppsSearchController(), title: "Search", imageName: #imageLiteral(resourceName: "search"))
        ]
    }
    
    
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        
        viewController.view.backgroundColor = .white
        navController.tabBarItem.title = title
        navController.tabBarItem.image = imageName
        
        viewController.navigationItem.title = title
        
        return navController
        
    }
}
