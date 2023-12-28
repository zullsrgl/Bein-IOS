//
//  AllMovieInteractor.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 26.12.2023.
//

import Foundation


class AllMovieInteractor {
    var allMoviePresenter : AllMoviePrsenterProtocol?
    var allMovieWorker : AllMoviesWorkerProtocol?
    
    init(allMoviePresenter: AllMoviePrsenterProtocol? = nil, allMovieWorker: AllMoviesWorkerProtocol? = nil) {
        self.allMoviePresenter = allMoviePresenter
        self.allMovieWorker = allMovieWorker ?? AllMovieWorker()
    }
    
    func getTrendingMovies() { 
        allMovieWorker?.getTrendingMovies { [weak self] result  in
            switch result {
            case .success(let movieDetail):
                self?.allMoviePresenter?.presentTrendingMovies(movieDetail)
            case .failure(let error) :
                print("DetailsInteractor Error: \(error)")
                
            }
        }
    }

    func getTrendingTv(){
        allMovieWorker?.getTrendingTV { [weak self] result  in
            switch result {
            case .success(let movieDetail):
                self?.allMoviePresenter?.presentTrendingMovies(movieDetail)
            case .failure(let error) :
                print("DetailsInteractor Error: \(error)")
                
            }
        }
    }
    func getUpComming(){
        allMovieWorker?.getUpcomingMovies{ [weak self] result  in
            switch result {
            case .success(let movieDetail):
                self?.allMoviePresenter?.presentTrendingMovies(movieDetail)
            case .failure(let error) :
                print("DetailsInteractor Error: \(error)")
                
            }
        }
    }
    func getPopuler(){
        allMovieWorker?.getPopuler{ [weak self] result  in
            switch result {
            case .success(let movieDetail):
                self?.allMoviePresenter?.presentTrendingMovies(movieDetail)
            case .failure(let error) :
                print("DetailsInteractor Error: \(error)")
                
            }
        }
    }
}
