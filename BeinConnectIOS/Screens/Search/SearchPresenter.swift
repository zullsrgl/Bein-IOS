//
//  SearchPresenter.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 26.12.2023.
//

import Foundation

protocol SearchPresenterProtocol : AnyObject {
    func presenterSearchedMovies(_ movies: [Title])
}
class SearchPresenter : SearchPresenterProtocol {
    weak var view: SearchViewProtocol?
    
    init(view: SearchViewProtocol? = nil) {
        self.view = view
    }
    
    func presenterSearchedMovies(_ movies: [Title]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.displaySearchedMovies(movies)
        }
    }
}
