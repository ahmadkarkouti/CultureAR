//
//  MainTabBarController.swift
//  CultureAR
//
//  Created by Ahmad Karkouty on 3/18/19.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.index(of: viewController)
        if index == 1 {
            let arViewController = ARController()
            present(arViewController, animated: true)
            return false
        } else {
            return true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupViewController()
        tabBar.isTranslucent = false
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
    }
    
    func setupViewController() {
        
        
        let HomeVC = UINavigationController(rootViewController: HomeController())
        HomeVC.tabBarItem.image = #imageLiteral(resourceName: "Home")
        HomeVC.tabBarItem.title = "Home"
        HomeVC.navigationBar.isHidden = true
        
        let PostVC = UINavigationController(rootViewController: ARController())
        PostVC.tabBarItem.image = #imageLiteral(resourceName: "Science")
        PostVC.tabBarItem.title = "Artefacts"
        PostVC.navigationBar.isHidden = true
        
        let ProfileVC = UINavigationController(rootViewController: ProfileController())
        ProfileVC.tabBarItem.image = #imageLiteral(resourceName: "User")
        ProfileVC.tabBarItem.title = "Profile"
        
        
        viewControllers = [HomeVC, PostVC, ProfileVC]
        tabBar.tintColor = .black
        
        // modifiy tab bar item insets
        guard let items = tabBar.items else {return}
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
}

