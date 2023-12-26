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
    
    func searchMovies(withKeyWord keyword: String) {
        APICaller.shared.getMovieName(keyWord: keyword) { [weak self] result in
            switch result {
            case .success(let movieList):
                self?.presenter?.presenterSearchedMovies(movieList)
            case .failure(let error):
                print("SearchInteractorFail: \(error)")
            }
        }
    }
    
}
