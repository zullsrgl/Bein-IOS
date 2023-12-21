//
//  TumFilmlerViewController.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 14.11.2023.
//

import UIKit
import SnapKit
import MapKit



class AllMovieViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var detailsVc: DetailProtocol?

    private var trendingMovies : [Title] = []
    var  selectedDataType : Int?
    var collectionView : UICollectionView?
    let titleName = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.size.width/3.3,
                                 height: view.frame.size.height/4.2)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifire)
        collectionView?.delegate = self
        collectionView?.dataSource = self
      
        collectionView?.backgroundColor = .black
        view.addSubview(collectionView!)
        nav()
        collectionView?.reloadData()
    }
    
    func nav (){
        titleName.textColor = .white
        titleName.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleName.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.titleView = titleName
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView?.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
        }
    }
  
    private func getPopulerData(){
        APICaller.shared.getPopuler{ [weak self] result in
               switch result{
               case .success(let titles):
                   DispatchQueue.main.async {
                       self?.trendingMovies = titles
                       self?.collectionView?.reloadData()
                   }
               case .failure(let error) :
                   print(error.localizedDescription)
            }
        }
    }
    
    private func getTrendingsMoviesData(){
        APICaller.shared.getTrendingMovies { [weak self] result in
             switch result{
             case .success(let titles):
                 DispatchQueue.main.async {
                     self?.trendingMovies = titles
                     self?.collectionView?.reloadData()
                 }
             case .failure(let error) :
                 print(error.localizedDescription)
             }
         }
    }
    
    private func getTrendingTvsData(){
        APICaller.shared.getTrendingTvs { [weak self] result in
             switch result{
             case .success(let titles):
                 DispatchQueue.main.async {
                     self?.trendingMovies = titles
                     self?.collectionView?.reloadData()
                 }
             case .failure(let error) :
                 print(error.localizedDescription)
             }
         }
        
    }
    private func getUpcomingMoviesData() {
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result{
            case .success(let titles):
                DispatchQueue.main.async {
                    self?.trendingMovies = titles
                    self?.collectionView?.reloadData()
                }
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
    
    func didTapSeeAllButton(as index :Int){
        print("tapped index \(index)")
        selectedDataType = index
        if index == 0 {
            titleName.text = "Trend Filmler"
            //titleName.text =
            getPopulerData()
        }
        else if index == 1 {
            titleName.text = "Trand Diziler"
            
            getTrendingTvsData()
        }
        else if index == 2 {
            titleName.text = "Popülerler"
            getTrendingsMoviesData()
        }
        else if index == 3 {
            getUpcomingMoviesData()
            titleName.text = "Yakında Gelecekler"
        }
        else {
            print("error")
        }
        collectionView?.reloadData()
        
    }

   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifire, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: trendingMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let movieID =  trendingMovies[indexPath.row].id
        let detailsVc = DetailsViewController(movieID: movieID)
        navigationController?.pushViewController(detailsVc, animated: true)
    }
}
