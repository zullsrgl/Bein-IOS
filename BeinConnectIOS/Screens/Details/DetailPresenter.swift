//
//  DetailPresenter.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 26.12.2023.
//

import Foundation
protocol DetailPresenterProtocol : AnyObject {
    func presenterDetail(_ movieDetail: MovieDetail)
}
class DetailPresenter : DetailPresenterProtocol{
    weak var view: DetailViewProtocol?
    
    init(view: DetailsViewController? = nil) {
        self.view = view
    }
    
    func presenterDetail(_ movieDetail: MovieDetail) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.displayDetailMovies(movieDetail)
        }
    }
}
