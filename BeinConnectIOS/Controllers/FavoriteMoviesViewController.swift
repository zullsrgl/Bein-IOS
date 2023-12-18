//
//  SporViewController.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 7.11.2023.
//

import UIKit
import Kingfisher

class FavoriteMoviesViewController: UIViewController {
    var movieList : [MovieDetail] = []
    var favoriteTableView : UITableView = {
        var table = UITableView()
        table.backgroundColor =  .black
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        favoriteTableView.register(SearchViewTableViewCell.self, forCellReuseIdentifier: SearchViewTableViewCell.identifier)
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        view.addSubview(favoriteTableView)
        constraint()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateJson()
        
    }
    
    
    func updateJson() {
           if let favouritesStringArray = UserDefaults.standard.array(forKey: "favourites") as? [String] {
               if let favouritesDataArray = favouritesStringArray.map({ $0.data(using: .utf8) }) as? [Data] {
                   var favouritesList: [MovieDetail] = []
                   for data in favouritesDataArray {
                       do {
                           let decoder = JSONDecoder()
                           let movie = try decoder.decode(MovieDetail.self, from: data)
                           favouritesList.append(movie)
                       } catch {
                           print("Hata oluştu: \(error.localizedDescription)")
                       }
                   }
                   movieList = favouritesList
                   favoriteTableView.reloadData()
               } else {
                   print("String dizisini Data dizisine çevirme hatası.")
               }
           } else {
               print("Favoriler bulunamadı.")
           }
       }

    func constraint(){
        favoriteTableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
}


extension FavoriteMoviesViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewTableViewCell.identifier, for: indexPath) as? SearchViewTableViewCell else{
            return UITableViewCell()
        }
        let movie = movieList[indexPath.row]
        if let imageURL = URL(string: movie.poster_path ?? "") {
            let baseUrl = "https://image.tmdb.org/t/p/w1280"
            let fullUrl = URL(string: baseUrl + imageURL.absoluteString)
            if let url = fullUrl {
                cell.movieImage.kf.setImage(with: url)
            }
        }
        cell.movieNameLabel.text = "\(movie.original_title!)"
        cell.voteAverageLabel.text = "\(movie.vote_average!)"
        cell.voteCountLabel.text = "\(movie.release_date!)"
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        return cell
    }
}
