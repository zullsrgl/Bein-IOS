//
//  AllMoviePrsenter.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 26.12.2023.
//

import Foundation

protocol AllMoviePrsenterProtocol : AnyObject {
    func presentTrendingMovies(_ titles: [Title])
    func presentTrendingTv(_ titles: [Title])
    func presentUpcomingMovies(_ titles: [Title])
    func presentPopuler(_ titles: [Title])
}


class AllMoviePrsenter : AllMoviePrsenterProtocol {
    weak var view : AllViewControllerProtocol?
    
    func presentTrendingMovies(_ titles: [Title]) {
        view?.displayTrendingTv(titles)
    }
    
    func presentTrendingTv(_ titles: [Title]) {
        view?.displayTrendingTv(titles)
    }
    
    func presentUpcomingMovies(_ titles: [Title]) {
        view?.displayUpcomingMovies(titles)
    }
    
    func presentPopuler(_ titles: [Title]) {
        view?.displayPopuler(titles)
    }
    
    
}
