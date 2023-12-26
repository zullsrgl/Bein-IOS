//
//  HomeInteractor.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 25.12.2023.
//

import Foundation

class HomeInteractor {
    var presenter: HomePresenterProtocol?

    func getTrendingMovies() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.presenter?.presentTrendingMovies(titles)
            case .failure(let error):
                print("Hata: \(error)")
            }
        }
    }

    func getTrendingTv() {
        APICaller.shared.getTrendingTvs { [weak self] result in
            switch result {
            case .success(let titles):
                self?.presenter?.presentTrendingTv(titles)
            case .failure(let error):
                print("Hata: \(error)")
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
