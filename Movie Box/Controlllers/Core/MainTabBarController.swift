//
//  ViewController.swift
//  Movie Box
//
//  Created by Александр Прайд on 30.05.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTabBarController()
    }
    


}

extension MainTabBarController {
    
    private func setupTabBarController() {
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let upcomingVC = UINavigationController(rootViewController: UpcomingViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let userListVC = UINavigationController(rootViewController: UserBoxViewController())
        
        setViewControllers([homeVC, upcomingVC, searchVC, userListVC], animated: true)
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        upcomingVC.tabBarItem.image = UIImage(systemName: "circle.hexagongrid")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        userListVC.tabBarItem.image = UIImage(systemName: "arrowtriangle.down")
        
        homeVC.title = "Home"
        upcomingVC.title = "Comming Soon"
        searchVC.title = "Search"
        userListVC.title = "My Box"
        
        tabBar.tintColor = .systemGreen
        
    }
    
}

