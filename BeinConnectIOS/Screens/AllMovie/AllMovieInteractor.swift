//
//  AllMovieInteractor.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 26.12.2023.
//

import Foundation


class AllMovieInteractor {
    var allMoviePresenter : AllMoviePrsenterProtocol?
    
    func getTrendingMovies() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.allMoviePresenter?.presentUpcomingMovies(titles)
            case .failure(let error):
                print("Hata: \(error)")
            }
        }
    }

    func getTrendingTv(){
        APICaller.shared.getTrendingTvs { [weak self] result in
            switch result {
            case .success(let titles):
                self?.allMoviePresenter?.presentTrendingTv(titles)
            case .failure(let error) :
                print("All Movies Interactor Error : \(error)")
            }
        }
    }
    func getUpComming(){
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.allMoviePresenter?.presentUpcomingMovies(titles)
            case .failure(let error) :
                print("All Movies Interactor Error : \(error)")
            }
        }
    }
    func getPopuler(){
        APICaller.shared.getPopuler { [weak self] result in
            switch result {
            case .success(let titles):
                self?.allMoviePresenter?.presentPopuler(titles)
            case .failure(let error) :
                print("All Movies Interactor Error : \(error)")
            }
        }
    }
    
}
