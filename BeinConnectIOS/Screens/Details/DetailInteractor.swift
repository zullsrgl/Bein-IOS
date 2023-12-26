//
//  DetailInteractor.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 26.12.2023.
//

import Foundation

protocol DetailInteractorProtocol : AnyObject {
    func detailMovie(withId id: Int)
}
class DetailInteractor : DetailInteractorProtocol {
    var detailPresenter: DetailPresenterProtocol?
    
    func detailMovie(withId id: Int) {
        APICaller.shared.getMovieDetails(id: id) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                self?.detailPresenter?.presenterDetail(movieDetail)
            case .failure(let error):
                print("DetailInteractor Error: \(error)")
            }
        }
    }
}
