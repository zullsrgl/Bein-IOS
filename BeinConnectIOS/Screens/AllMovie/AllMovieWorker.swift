//
//  AllMovieWorker.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 28.12.2023.
//

import Foundation

protocol AllMoviesWorkerProtocol : AnyObject {
    func getTrendingMovies(completion: @escaping(Result<[Title], Error>) -> Void)
    func getTrendingTV(completion: @escaping(Result<[Title], Error>) -> Void)
    func getUpcomingMovies(completion: @escaping(Result<[Title], Error>) -> Void)
    func getPopuler(completion: @escaping(Result<[Title], Error>) -> Void)
}

class AllMovieWorker : AllMoviesWorkerProtocol{
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        APICaller.shared.getTrendingMovies { result in
            completion(result)
        }
    }
    
    func getTrendingTV(completion: @escaping (Result<[Title], Error>) -> Void) {
        APICaller.shared.getTrendingTvs { result in
            completion(result)
        }
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        APICaller.shared.getUpcomingMovies { result in
            completion(result)
        }
    }
    
    func getPopuler(completion: @escaping (Result<[Title], Error>) -> Void) {
        APICaller.shared.getPopuler { result in
            completion(result)
        }
    }
    
    
}
