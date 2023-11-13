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
        let vc1 = UINavigationController(rootViewController: FilmViewController())
        let vc2 = UINavigationController(rootViewController: DiziViewController())
        let vc3 = UINavigationController(rootViewController: SporViewController())
        let vc4 = UINavigationController(rootViewController: CocukViewController())
        let vc5 = UINavigationController(rootViewController: CanliTvViewController())
    
        vc1.tabBarItem.title = "Film"
        vc2.tabBarItem.title = "Dizi"
        vc3.tabBarItem.title = "Spor"
        vc4.tabBarItem.title = "Çocuk"
        vc5.tabBarItem.title = "Canlı"
        
        setViewControllers([vc1,vc2,vc3,vc4,vc5], animated: true)
       
       
    }
    override func viewDidLayoutSubviews() {
        view.backgroundColor = .red
        let height  = navigationController?.navigationBar.frame.maxY
        tabBar.frame = CGRect(x: 0, y: height ?? 0, width: tabBar.frame.size.width, height: 150.0)
        super.viewDidLayoutSubviews()
        
        
    }
   
}
