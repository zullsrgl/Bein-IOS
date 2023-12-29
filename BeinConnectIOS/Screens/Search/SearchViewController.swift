//
//  DiziViewController.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 7.11.2023.
//

import UIKit
protocol SearchViewProtocol: AnyObject {
    func displaySearchedMovies(_ movies: [Title])
}
class SearchViewController: UIViewController , SearchViewProtocol{

    private let searchRouter = SearchRouter.shared
    private let searchInteractor = SeachInteractor()
    private var searchPresenter = SearchPresenter()
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
        searchInteractor.presenter = searchPresenter
        searchPresenter.view = self
        searchRouter.navController = navigationController!
        
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
    func displaySearchedMovies(_ movies: [Title]) {
        movieList = movies
        tableview.reloadData()
    }
    
}
extension SearchViewController :  UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { //whenever the enter is clicked
        guard let keyword = searchBar.text else {return}
        searchInteractor.searchMovies(withKeyWord: keyword)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movieList[indexPath.row]  //??
        let movieId = movie.id
        navigateDetailVc(withID: movieId)
        print("Select Index : \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewTableViewCell.identifier, for: indexPath) as? SearchViewTableViewCell else {
            return UITableViewCell()
        }
        let movie = movieList[indexPath.row]  //??
        cell.configure(with: movie)
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        return cell
    }
}
extension SearchViewController : DetailProtocol {
    func navigateDetailVc(withID movieID: Int) {
        searchRouter.navigateDetailVc(withID: movieID)
    }
}
