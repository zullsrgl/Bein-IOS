//
//  DiziViewController.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 7.11.2023.
//

import UIKit

class SearchViewController: UIViewController{
    var movieList: [Title] = []
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor =  .black
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
      }()
    
    let searchbar : UISearchBar = {
        var search = UISearchBar()
        search.barStyle = .black
        return search
    }()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        searchbar.delegate = self
        setupTableView()
    }
    
    func setupTableView() {
        tableview.register( SearchViewTableViewCell.self , forCellReuseIdentifier: SearchViewTableViewCell.identifier)
        view.addSubview(tableview)
        view.addSubview(searchbar)
        tableview.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        searchbar.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.bottom.equalTo(tableview.snp.top)
            make.left.right.equalToSuperview()
        }
    
    }
   
}

extension SearchViewController :  UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { //whenever the enter is clicked
        APICaller.shared.getMovieName(keyWord: searchBar.text ) {  [weak self] result in
            switch result {
            case .success(let movieList):
                DispatchQueue.main.async {
                    self?.movieList = movieList
                    self?.tableview.reloadData()
                }
                 print("movie Name : \(movieList)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selectRow : \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewTableViewCell.identifier, for: indexPath) as? SearchViewTableViewCell else {
            return UITableViewCell()
        }
        let movie = movieList[indexPath.row]
        if let imageURL = URL(string: movie.poster_path ?? ""){
            cell.configure(with: imageURL)
        }
        else {
            print("imageURL error")
        }
        cell.selectionStyle = .none
        cell.movieNameLabel.textColor = .white
        cell.movieNameLabel.text =  movie.original_title ?? movie.original_name
        cell.backgroundColor = .black
        return cell
    }
  
}
