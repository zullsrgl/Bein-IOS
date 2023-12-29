//
//  HomePresenter.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 25.12.2023.
//

import Foundation
protocol HomePresenterProtocol{
    func presentTrendingMovies(_ titles: [Title])
    func presentTrendingTv(_ titles: [Title])
    func presentUpcomingMovies(_ titles: [Title])
    func presentPopuler(_ titles: [Title])
}

class HomePresenter: HomePresenterProtocol {
    weak var viewController: HomeViewControllerProtocol?

    func presentTrendingMovies(_ titles: [Title]) {
        viewController?.displayTrendingMovies(titles)
    }
    func presentTrendingTv(_ titles: [Title]) {
        viewController?.displayTrendingTv(titles)
    }
    func presentUpcomingMovies(_ titles: [Title]) {
        viewController?.displayUpcomingMovies(titles)
    }
    func presentPopuler(_ titles: [Title]) {
        viewController?.displayPopuler(titles)
    }
}
