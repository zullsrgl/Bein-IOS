//
//  DiziViewController.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 7.11.2023.
//

import UIKit

class SearchViewController: UIViewController{
    var searchTimer : Timer?
    
    let tableview: UITableView = {
          let tv = UITableView()
        tv.backgroundColor =  .black
          tv.translatesAutoresizingMaskIntoConstraints = false
          return tv
      }()
    
    let searchbar : UISearchBar = {
        var search = UISearchBar()
        search.barStyle = .black
        search.accessibilityHint = "Movie Name?"
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
        tableview.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifire)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifire, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = "index numarası: \(indexPath.row)"
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { //whenever the enter is clicked
        APICaller.shared.getMovieName(keyWord: searchBar.text ) {  [weak self] result in
            switch result {
            case .success(let movieList):
                print("movie Name : \(movieList)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

