//
//  TabBarViewController.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 7.11.2023.
//

import Foundation
import UIKit

class TabBarViewController : UITabBarController, UITabBarControllerDelegate{
 override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: FavoriteMoviesViewController())

        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "suit.heart.fill")

        vc1.tabBarItem.title = "Filmler"
        vc2.tabBarItem.title = "Ara"
        vc3.tabBarItem.title = "Favoriler"
     
        setViewControllers([vc1,vc2,vc3], animated: false)
                
    let tabBarItem = UITabBarItem.appearance()
    let attributes = [NSAttributedString.Key.font:UIFont(name: "Arial", size: 16)]
    tabBarItem.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
    tabBar.barTintColor = UIColor.black.withAlphaComponent(0.0)
      
     
     let navigationViewController = UINavigationController()
     navigationViewController.navigationBar.backgroundColor = .cyan
     let appearance = UINavigationBarAppearance()
     appearance.backgroundColor = .black
     UINavigationBar.appearance().standardAppearance = appearance
     UINavigationBar.appearance().compactAppearance = appearance
     UINavigationBar.appearance().scrollEdgeAppearance = appearance
     
     
 }
}
