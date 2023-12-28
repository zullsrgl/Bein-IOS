//
//  DetailsWorker.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 27.12.2023.
//

import Foundation


protocol DetailsWorkerProtocol {
    func getMoviesDetails(withId id : Int, completion: @escaping (Result <MovieDetail, Error>) -> Void)
}

class DetailsWorker : DetailsWorkerProtocol {
    weak var interactor : DetailInteractorProtocol?
    
    init(interactor: DetailInteractorProtocol? = nil) {
        self.interactor = interactor
    }
    
    func getMoviesDetails(withId id: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        APICaller.shared.getMovieDetails(id: id) { result in
            completion(result)
        }
    }
}
