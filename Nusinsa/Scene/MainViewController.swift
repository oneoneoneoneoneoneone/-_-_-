//
//  MainViewController.swift
//  Nusinsa
//
//  Created by hana on 2022/08/12.
//

import UIKit

class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let categoryViewController = UINavigationController(rootViewController: UIViewController())
        categoryViewController.tabBarItem = UITabBarItem(
            title: "카테고리",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 0
        )
        
        let snapViewController = UINavigationController(rootViewController: UIViewController())
        snapViewController.tabBarItem = UITabBarItem(
            title: "스냅",
            image: UIImage(systemName: "tag"),
            tag: 0
        )
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        homeViewController.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        
        let likeViewController = UINavigationController(rootViewController: UIViewController())
        likeViewController.tabBarItem = UITabBarItem(
            title: "좋아요",
            image: UIImage(systemName: "heart"),
            tag: 0
        )
        
        let myViewController = UINavigationController(rootViewController: UIViewController())
        myViewController.tabBarItem = UITabBarItem(
            title: "마이",
            image: UIImage(systemName: "person"),
            tag: 0
        )
        
        viewControllers = [categoryViewController, snapViewController, homeViewController, likeViewController, myViewController]
        self.selectedIndex = 2
        
        tabBar.backgroundColor = .darkText
        tabBar.tintColor = .white
        tabBar.barTintColor = .systemGray
        tabBar.unselectedItemTintColor = .systemGray
    }
}

