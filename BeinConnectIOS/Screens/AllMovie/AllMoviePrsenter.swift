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
    var allMovieWorker : AllMovieWorker?
    
    init(view: AllViewControllerProtocol? = nil, allMovieWorker: AllMovieWorker? = nil) {
        self.view = view
        self.allMovieWorker = allMovieWorker
    }
    
    func presentTrendingMovies(_ titles: [Title]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.displayTrendingMovies(titles)
        }
    }
    
    func presentTrendingTv(_ titles: [Title]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.displayTrendingTv(titles)
        }
    }
    
    func presentUpcomingMovies(_ titles: [Title]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.displayUpcomingMovies(titles)
        }

    }
    
    func presentPopuler(_ titles: [Title]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.displayPopuler(titles)
        }
    }
}
