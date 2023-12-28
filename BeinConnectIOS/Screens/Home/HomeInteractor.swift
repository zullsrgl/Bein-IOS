//
//  HomeInteractor.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 25.12.2023.
//

import Foundation

class HomeInteractor {
    var presenter: HomePresenterProtocol?
    var homeWorker : HomeWorkerProtocol?
    init(presenter: HomePresenterProtocol? = nil, homeWorker: HomeWorkerProtocol? = nil) {
        self.presenter = presenter
        self.homeWorker = homeWorker ?? HomeWorker()
    }
    
    func getTrendingMovies() {
        homeWorker?.getTrendingMovies{ [weak self] result  in
            switch result {
            case .success(let movieDetail):
                self?.presenter?.presentTrendingMovies(movieDetail)
            case .failure(let error) :
                print("DetailsInteractor Error: \(error)")
            }
            
        }
    }

    func getTrendingTv() {
        homeWorker?.getTrendingTV{ [weak self] result  in
            switch result {
            case .success(let movieDetail):
                self?.presenter?.presentTrendingTv(movieDetail)
            case .failure(let error) :
                print("DetailsInteractor Error: \(error)")
            }
            
        }
    }

    func getUpcomingMovies() {
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.presenter?.presentUpcomingMovies(titles)
            case .failure(let error):
                print("Hata: \(error)")
                
            }
        }
    }
    func getPopuler() {
        APICaller.shared.getPopuler{ [weak self] result in
            switch result {
            case .success(let titles):
                self?.presenter?.presentPopuler(titles)
            case .failure(let error):
                print("Hata: \(error)")
                
            }
        }
    }
}
