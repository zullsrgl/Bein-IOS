//
//  SearchWorker.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 28.12.2023.
//

import Foundation
protocol SearchWorkerProtocol : AnyObject {
    func getMovieName(keyWord: String? ,completion : @escaping (Result<[Title], Error>) -> Void)
}

class SearchWorker : SearchWorkerProtocol{
    var searchInteractor: SearchInteractorProtocol?
    
    
    init(searchInteractor: SearchInteractorProtocol? = nil) {
        self.searchInteractor = searchInteractor
    }
    
    
    func getMovieName(keyWord: String?, completion: @escaping (Result<[Title], Error>) -> Void) {
        APICaller.shared.getMovieName(keyWord: keyWord) { result in
            completion(result)
        }
    }
    
    
}
