//
//  MainTabController.swift
//  DesignerApp
//
//  Created by Moe on 29/04/2019.
//  Copyright © 2019 Mohammed salem bajuaifer. All rights reserved.
//


import UIKit

class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UITabBar.appearance().barTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) //#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)// your color
        
        tabBar.tintColor = #colorLiteral(red: 0.9654689431, green: 0.7616818547, blue: 0.1046115384, alpha: 1)
        
        // tab
        viewControllers = [
            createNavController(viewController: HomeViewController(), name: "Explore Designs", image: "Home"),
            createNavController(viewController: UIViewController(), name: "Home", image: "Home"),
            createNavController(viewController: UIViewController(), name: "Profile", image: "Profile")
        ]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        //        tabBar.selectedItem?.firs
    }
    
    
    func createNavController(viewController: UIViewController, name: String, image: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        
        viewController.navigationItem.title = name
        viewController.view.backgroundColor = #colorLiteral(red: 0.4151936173, green: 0.412730217, blue: 0.4170902967, alpha: 1)
        //        navController.tabBarItem.title = name
        navController.tabBarItem.image = UIImage(named: image)
   
        return navController
    }
}

