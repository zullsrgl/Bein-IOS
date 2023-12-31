//
//  DetailsViewController.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 21.11.2023.
//

import UIKit
import AVKit

protocol DetailViewProtocol: AnyObject {
    func displayDetailMovies(_ movies: MovieDetail)
}

class DetailsViewController: UIViewController, DetailViewProtocol{
    private var detailVCInteractor = DetailInteractor()
    private var detailVcPresenter = DetailPresenter()
    
    let movieID: Int?
    var movieDetail: MovieDetail?
    init(movieID: Int) {
        self.movieID = movieID
        print("movie Id : \(movieID)")
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("Gelen id çalışmadı")
    }
    var overviewLabel : UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(overviewLabel)
        
        detailVCInteractor.detailPresenter = detailVcPresenter
        detailVcPresenter.view = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailsCollectionViewCell.self, forCellReuseIdentifier: DetailsCollectionViewCell.identifire)
        tableView.register(WatchButonCollectionViewCell.self, forCellReuseIdentifier: WatchButonCollectionViewCell.identifire)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setConstraints()  
        if let movieID = movieID {
            detailVCInteractor.detailMovie(withId: movieID)
        }
     
    }  
    func displayDetailMovies(_ movieDetail: MovieDetail) {
           self.movieDetail = movieDetail
           DispatchQueue.main.async { [weak self] in
               self?.tableView.reloadData()
           }
       }
    func setConstraints(){
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.left.bottom.equalToSuperview()
        }
    }
}
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource, WatchButonCellDelegate {
    func presentPlayerController(_ playerController: AVPlayerViewController) {
        self.present(playerController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 250        }
        else if indexPath.row == 1 {
            return UITableView.automaticDimension
        }
        else if indexPath.row == 2 {
            return 150
        }
        else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailsCollectionViewCell.identifire, for: indexPath) as! DetailsCollectionViewCell

            cell.selectionStyle = .none
            cell.movieDetail = self.movieDetail
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
          
            cell.backgroundColor  = .black
            cell.selectionStyle = .none
            cell.textLabel?.textColor = .white
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = movieDetail?.overview
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: WatchButonCollectionViewCell.identifire, for: indexPath) as! WatchButonCollectionViewCell
            cell.delegate = self
            cell.selectionStyle = .none
            cell.backgroundColor = tableView.backgroundColor
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
}
