//
//  MainTabBarController.swift
//  CultureAR
//
//  Created by Ahmad Karkouty on 3/18/19.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    
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
//        HomeVC.tabBarItem.image = #imageLiteral(resourceName: "costume_eow_gold1.jpg")
        HomeVC.tabBarItem.title = "Home"
        HomeVC.navigationBar.isHidden = true
        
        let PostVC = UINavigationController(rootViewController: PostController())
        //        HomeVC.tabBarItem.image = #imageLiteral(resourceName: "costume_eow_gold1.jpg")
        PostVC.tabBarItem.title = "Post"
        PostVC.navigationBar.isHidden = true
        
        let ProfileVC = UINavigationController(rootViewController: ProfileController())
        //        HomeVC.tabBarItem.image = #imageLiteral(resourceName: "costume_eow_gold1.jpg")
        ProfileVC.tabBarItem.title = "Profile"
        ProfileVC.navigationBar.isHidden = true
        
        viewControllers = [HomeVC, PostVC, ProfileVC]
        tabBar.tintColor = .black
        
        // modifiy tab bar item insets
        guard let items = tabBar.items else {return}
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
}

