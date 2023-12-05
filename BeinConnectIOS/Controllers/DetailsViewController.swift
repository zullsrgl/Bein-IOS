//
//  DetailsViewController.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 21.11.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private var movieDetail: MovieDetail?
    
    var backButtonDetails : UIButton = {
        var button  = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(button.tintColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backDetailsToYabanciFilmler), for: .touchUpInside)
        
        return button
        
    }()


    var overviewLabel : UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

     //  label.text = "When the walker  family members switch bodies with each other during a rare planetary alignment, their     hilarious journey to find their way back to normal will bring them closer together than they ever thought possible"
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
        view.addSubview(backButtonDetails)
        view.addSubview(tableView)
        view.addSubview(overviewLabel)
        
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailsCollectionViewCell.self, forCellReuseIdentifier: DetailsCollectionViewCell.identifire)
        tableView.register(WatchButonCollectionViewCell.self, forCellReuseIdentifier: WatchButonCollectionViewCell.identifire)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setConstraints()
        getMovieDetails()
    }
    
    private func getMovieDetails() {
        
        APICaller.shared.getMovieDetails(id: 346698) { [weak self] result in
            switch result{
                case .success(let movieDetail):
                DispatchQueue.main.async {
                    self?.movieDetail = movieDetail
                    self?.tableView.reloadData()
                }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    
     }

    func setConstraints(){
        backButtonDetails.snp.makeConstraints { make in
            make.top.equalTo(40)
            make.left.equalTo(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backButtonDetails.snp.bottom)
            make.right.left.bottom.equalToSuperview()
        }
    }
   
    func startAnimation(){
    }
    @objc func backDetailsToYabanciFilmler(){
        print(" Details back button click")
        navigationController?.popViewController(animated: true)
    }
}
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        }
        else if indexPath.row == 1 {

          
            return 180
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
            cell.selectionStyle = .none
            cell.backgroundColor = .black
            cell.textLabel?.textColor = .white
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = movieDetail?.overview
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: WatchButonCollectionViewCell.identifire, for: indexPath) as! WatchButonCollectionViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = .black
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
}
