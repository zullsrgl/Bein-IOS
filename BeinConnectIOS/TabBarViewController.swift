//
//  TabBarViewController.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 7.11.2023.
//

import Foundation
import UIKit



class TabBarViewController : UITabBarController{
  
    override func viewDidLoad() {
        super.viewDidLoad()
        appNameForTabBar()
        let vc1 = UINavigationController(rootViewController: YabanciFilmViewController())
        let vc2 = UINavigationController(rootViewController: YerliFilmViewController())
        let vc3 = UINavigationController(rootViewController: BetimlemeViewController())
    
        
        vc1.tabBarItem.title = "Yabancı Film"
        vc2.tabBarItem.title = "Yerli Film"
        vc3.tabBarItem.title = "Betimleme"
        setViewControllers([vc1,vc2,vc3], animated: true)
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Arial", size: 16)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        tabBar.barTintColor = UIColor.black.withAlphaComponent(0.5)
       
    }
    override func viewDidLayoutSubviews() {
        let height  = navigationController?.navigationBar.frame.maxY
        tabBar.frame = CGRect(x: 0, y: height ?? 0, width: tabBar.frame.size.width, height: 110.0)
        super.viewDidLayoutSubviews()
        
        
    }
    
    func appNameForTabBar(){
        
        let appName =  UILabel(frame: CGRect(origin: .init(x: (view.frame.width/2)-15, y: 56), size: CGSize(width: 30.0, height: 60.0)))
        appName.textAlignment = .center
        appName.font = .boldSystemFont(ofSize: 20)
        appName.text = "FİLM"
        appName.textColor = .white
        appName.sizeToFit()
        self.tabBar.addSubview(appName)
    }
}