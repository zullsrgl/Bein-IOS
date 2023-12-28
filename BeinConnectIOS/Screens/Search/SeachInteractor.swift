//
//  SeachInteractor.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 26.12.2023.
//

import Foundation
protocol SearchInteractorProtocol : AnyObject {
    func searchMovies(withKeyWord keyword: String)
}

class SeachInteractor  : SearchInteractorProtocol{
    var presenter : SearchPresenterProtocol?
    var searchWorker : SearchWorkerProtocol?
    
    
    init(presenter: SearchPresenterProtocol? = nil, searchWorker: SearchWorkerProtocol? = nil) {
        self.presenter = presenter
        self.searchWorker = searchWorker ?? SearchWorker()
    }
    
    func searchMovies(withKeyWord keyword: String) {
        searchWorker?.getMovieName(keyWord: keyword) { [weak self] result in
            switch result{
            case .success(let movieName):
                self?.presenter?.presenterSearchedMovies(movieName)
            case .failure(let error):
                print("Search Interactor Error : \(error)")
            }
        }
    }
    
}
