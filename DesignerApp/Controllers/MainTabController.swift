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
        
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tabBar.tintColor = #colorLiteral(red: 0.9654689431, green: 0.7616818547, blue: 0.1046115384, alpha: 1)
        
        viewControllers = [
            createNavController(viewController: CategoryViewController(), name: "Explore", image: "images-icon", selectedImage: "colored-images-icon"),
            createNavController(viewController: HomeViewController(), name: "Search", image: "search", selectedImage: "colored-search"),
            createNavController(viewController: UIViewController(), name: "Profile", image: "user-profile", selectedImage: "colored-user-profile")
        ]
        
        guard let items = tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        }
    }
    
    func createNavController(viewController: UIViewController, name: String, image: String, selectedImage: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        
        viewController.navigationItem.title = name
        viewController.view.backgroundColor = #colorLiteral(red: 0.4151936173, green: 0.412730217, blue: 0.4170902967, alpha: 1)
        //        navController.tabBarItem.title = name
        navController.tabBarItem.image = UIImage(named: image)
        navController.tabBarItem.selectedImage = UIImage(named: selectedImage)
        viewController.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.9647058824, green: 0.7607843137, blue: 0.1058823529, alpha: 1)]
        viewController.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9654689431, green: 0.7616818547, blue: 0.1046115384, alpha: 1)
        viewController.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        return navController
    }
}

