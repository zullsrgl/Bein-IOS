//
//  DiziViewController.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 7.11.2023.
//

import UIKit

class YerliFilmViewController: UIViewController{
    
    let tableview: UITableView = {
          let tv = UITableView()
          tv.backgroundColor = UIColor.white
          tv.translatesAutoresizingMaskIntoConstraints = false
          return tv
      }()
    
    let searchbar : UISearchBar = {
        var search = UISearchBar()
        search.barStyle = .black
        search.text = "Movie Name"
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        searchbar.delegate = self
        searchbar.endEditing(false)
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


extension YerliFilmViewController :  UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
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
   func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool { //Cancel
       searchBar.setShowsCancelButton(true, animated: true)
       return true
   }
}

