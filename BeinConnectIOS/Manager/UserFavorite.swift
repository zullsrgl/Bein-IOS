//
//  UserFavorite.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 19.12.2023.
//

import Foundation

class MovieManager {
    static let shared = MovieManager()
    
    func saveFavorite(movieDetail : MovieDetail){
        do{
            let jsonEncoder = JSONEncoder()
            guard let jsonData = try? jsonEncoder.encode(movieDetail) else { return }
            let json =  String(data: jsonData, encoding: .utf8)
            
            if let json = json {
                var favoritesList = UserDefaults.standard.array(forKey: "favourites") as? [String] ?? []
                favoritesList.append(json)
                UserDefaults.standard.set(favoritesList, forKey: "favourites")
            }
        } catch {
            print("Hata: \(error)")
        }
    }
    
    func getFavoriteMovies() -> [MovieDetail] {
        if let favoritesStringArray = UserDefaults.standard.array(forKey: "favourites") as? [String] {
            var favoritesList: [MovieDetail] = []
            
            for jsonString in favoritesStringArray {
                if let jsonData = jsonString.data(using: .utf8) {
                    do {
                        let decoder = JSONDecoder()
                        let movie = try decoder.decode(MovieDetail.self, from: jsonData)
                        favoritesList.append(movie)
                    } catch {
                        print("Hata oluştu: \(error.localizedDescription)")
                    }
                }
            }
            
            return favoritesList
        } else {
            print("Favoriler bulunamadı.")
            return []
        }
    }
    func deleteFavorite(movieDetail: MovieDetail) {
        do{
            var favoritesList = getFavoriteMovies()
            var favoritesListJson = UserDefaults.standard.array(forKey: "favourites") as? [String] ?? []
                        
            var index = favoritesList.firstIndex { value in
                return value.id == movieDetail.id
            }
            
            if let index = index {
                favoritesListJson.remove(at: index)
                UserDefaults.standard.set(favoritesListJson, forKey: "favourites")
            }
        } catch {
            print("Hata: \(error)")
        }
    }
    
}
