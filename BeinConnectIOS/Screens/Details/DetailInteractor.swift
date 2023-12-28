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
    var worker : DetailsWorkerProtocol?
    
    
    init(detailPresenter: DetailPresenterProtocol? = nil, worker: DetailsWorkerProtocol? = nil) {
        self.detailPresenter = detailPresenter
        self.worker = worker ?? DetailsWorker()
    }
    
    func detailMovie(withId id: Int) {
        worker?.getMoviesDetails(withId: id) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                self?.detailPresenter?.presenterDetail(movieDetail)
            case .failure(let error) :
                print("DetailsInteractor Error: \(error)")
                
            }
        }
    }
}
