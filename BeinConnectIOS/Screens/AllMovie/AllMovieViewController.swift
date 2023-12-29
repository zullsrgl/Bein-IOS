//
//  TumFilmlerViewController.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 14.11.2023.
//

import UIKit
import SnapKit
import MapKit

protocol AllViewControllerProtocol : AnyObject{
    func displayTrendingMovies(_ titles: [Title])
    func displayTrendingTv(_ titles: [Title])
    func displayUpcomingMovies(_ titles: [Title])
    func displayPopuler(_ titles: [Title])
}


class AllMovieViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AllViewControllerProtocol {
   
    private let allMovieRouter = AllMovieRouter.shared
    private let allMovieInteractor = AllMovieInteractor()
    private let allMoviePresenter = AllMoviePrsenter()
    
    var detailsVc: DetailProtocol?
    private var trendingMovies : [Title] = []
    var  selectedDataType : Int?
    var collectionView : UICollectionView?
    let titleName = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allMovieInteractor.allMoviePresenter = allMoviePresenter
        allMoviePresenter.view = self
        
        
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
        allMovieRouter.navController = navigationController!
        
        collectionView?.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
        }
    }
    func displayTrendingMovies(_ titles: [Title]) {
        DispatchQueue.main.async {
            self.trendingMovies = titles
            self.collectionView?.reloadData()
            
        }
    }
    
    func displayTrendingTv(_ titles: [Title]) {
        DispatchQueue.main.async {
            self.trendingMovies = titles
            self.collectionView?.reloadData()
        }
    }
    
    func displayUpcomingMovies(_ titles: [Title]) {
        DispatchQueue.main.async {
            self.trendingMovies = titles
            self.collectionView?.reloadData()
            
        }
    }
    
    func displayPopuler(_ titles: [Title]) {
        DispatchQueue.main.async {
            self.trendingMovies = titles
            self.collectionView?.reloadData()
            
        }
    }
    private func getPopulerData(){
        allMovieInteractor.getPopuler()
    }
    
    private func getTrendingsMoviesData(){
        allMovieInteractor.getTrendingMovies()
    }
    
    private func getTrendingTvsData(){
        allMovieInteractor.getTrendingTv()
    }
    private func getUpcomingMoviesData() {
        allMovieInteractor.getUpComming()
    }
    
    
    func didTapSeeAllButton(as index :Int){
        print("tapped index \(index)")
        selectedDataType = index
        if index == 0 {
            titleName.text = "Trend Filmler"
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
        allMovieRouter.navigateToDetails(movieID: movieID)
    }
}
