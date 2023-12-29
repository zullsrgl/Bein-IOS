//
//  AllMovieRouter.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 29.12.2023.
//

import Foundation
import UIKit


class AllMovieRouter {
    static var shared = AllMovieRouter()
    var navController = UINavigationController()
    
    func navigateToDetails(movieID : Int) {
        let vc = DetailsViewController(movieID: movieID)
        navController.pushViewController(vc, animated: true)
    }   
}
