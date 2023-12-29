//
//  SearchRouter.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 29.12.2023.
//

import Foundation
import UIKit

class SearchRouter {
    static var shared = SearchRouter()
     var navController = UINavigationController()
    
    
    func navigateDetailVc(withID movieID: Int) {
        let vc = DetailsViewController(movieID: movieID)
        navController.pushViewController(vc, animated: true)
    }
}
