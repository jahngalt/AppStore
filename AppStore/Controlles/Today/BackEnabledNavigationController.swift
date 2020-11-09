//
//  BackEnabledNavigationController.swift
//  AppStore
//
//  Created by Oleg Kudimov on 11/2/20.
//

import UIKit


class BackEnabledNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.modalPresentationStyle = .fullScreen
        
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
}
