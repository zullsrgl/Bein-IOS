//
//  HomeRouter.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 28.12.2023.
//

import Foundation
import UIKit


class HomeRouter {
    
    static let shared = HomeRouter()
    var navController: UINavigationController?
    
    func navigateToDetailScreen(index: Int) {
        let viewController = AllMovieViewController()
        viewController.didTapSeeAllButton(as: index)
        navController?.pushViewController(viewController, animated: true)
    }
    
    func navigateDetailVc(withID movieID : Int) {
        let detailsVc = DetailsViewController(movieID: movieID)
        navController?.pushViewController(detailsVc, animated: true)
    }
    
    
}
