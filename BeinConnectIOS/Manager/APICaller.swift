//
//  APICaller.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 8.11.2023.
//

import Foundation

enum APIError : Error{
    case failedTohetData
}

struct Constants {
    static let API_KEY = "7e453b0f72f2441f91fecf6a5e810ebc"
    static let baseUrl = "https://api.themoviedb.org"
}
class APICaller {
    static let shared = APICaller()

    func getTrendingMovies(completion : @escaping (Result<[Title], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data, error == nil else {return}
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
                //completion(.success(result.results))
                
            }catch{
                completion(.failure(APIError.failedTohetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTvs(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data , error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))

            }catch {
                completion(.failure(APIError.failedTohetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedTohetData))
            }
        }
        task.resume()
    }
    func getPopuler(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/popular?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data , error == nil else {
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))

            }catch{
                completion(.failure(APIError.failedTohetData))
            }
        }
        task.resume()
    }
    func getMovieDetails(id: Int? ,completion : @escaping (Result<MovieDetail, Error>) -> Void){
        guard let movieId = id else {
            return
        }
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/\(movieId)?api_key=\(Constants.API_KEY)") else {return}
                
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data , error == nil else {
                return
            }
            do{
                let result = try JSONDecoder().decode(MovieDetail.self, from: data)
                completion(.success(result))

            }catch{
                completion(.failure(APIError.failedTohetData))
            }
        }
        task.resume()
    }

  
}

